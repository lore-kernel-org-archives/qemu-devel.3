Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67057C3600B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 02:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txziY-0000lO-B7; Thu, 27 Mar 2025 22:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txziQ-0000k2-1o
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 22:45:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txziN-0006sM-MS
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 22:45:01 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso2888287a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743129898; x=1743734698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Gk7nn7VAoqQb2xnUC8gyJUjH3N/ijAkhDdX9RfT55k=;
 b=mo83eM9UGz4vpGKzD2Cgs66+eUSlDHNYmLaDShGQj6i82eS0s3dmt27vadoNP0OvQw
 l+yJVksW1kQTIFhU1gLwLSLcal6woGybaA/jNb7SPtjrzqOklz8lmnCzlRSuFPMw7SNy
 gqMJCNIkV0k1ivE33vqbtin26QsNvFVo6sFyvKCSLxJAsQHyQRV54+pUrEKf2RBe2JDL
 eXwYmkuXaju1bUHTQUvRslq/t9cPJnMr126jFnvEmIXr6HZcV+dimWUjycAVkGPPu5S2
 fkLvpI0IO1hBSfZ5Rg9reWZ5dQUUTc2OTlD8s9+0wm92Db9otaXDhOCXxZG2RBbmC8wx
 fG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743129898; x=1743734698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Gk7nn7VAoqQb2xnUC8gyJUjH3N/ijAkhDdX9RfT55k=;
 b=fyuTDgniCLcNVDt0L5b3PvRgDOZzVUjRzOPUmR1GSqpW4mLoH1YcL6ST3XJcX+C0VR
 Zj/b2rxU/cO8aEHd3+1nwweALNmNI2u73XZhklo6KMp3I2VdW00FWnJXkNXDY7Ui9HOF
 B0LGe+GBvb0qjwWuwzTXpzjGFuVO5nyzh0Hi5azya85gOjeqSvEoh7b/UCz30QjZp+98
 ZR0GCVDU48Vg33nfuHS/vnL9uRgDmH4m6kbBZ8+vX54A0WfNkKh6RExCU4QfMidTUKir
 pMV4FmJsUdKFMsUcQpmB2ivydbBkhbBbOKQHx1ESKcmJY//OMWta+7/MMyj/mgQy+h5t
 POCA==
X-Gm-Message-State: AOJu0YzZ+weVAAX7hFymasNAk7A9BM4D52KMES+HkWPYt4r8lfeR+3Kw
 6L0jGDOeAILPSQ8TSj/pJSPz0VyM8WMQ0kXj0V2DdkwSrKPWc59n
X-Gm-Gg: ASbGncsyXMpZDKd0dFj0pzhUCI7lrH6kA3z5KodMIaXb7ohH8x/Ebsvoq6+Tra+zYVR
 d5NPPvQ1kU7unC+0+Cor7Dxbk6TGbAWeSNnMABdT/Sdo4NBYZeBmfm1Accke9Pniw+cMIiNxm7O
 q9014ejU1GyMiVyrcn5/ivlzW0kQs1opV1kgOI6s31yoNAg/53tAD1VTfH9aNeyoY6mL6Sc1GEM
 MmyQCygAR8sYaQMKk7MWkN2t2WY7kd5dCrH8Rgyh5LhNZ2psT1D7sDFrTwU+5zv/52yoGHp7HGv
 NnsjQKg125kiA55YwAu0Dt8BZzdEfLs9wtwfMflWIrHAzaLHYC+QJvjXuMN7u0lm
X-Google-Smtp-Source: AGHT+IGRIuvUlR7URQ+9VV6ZlJ7Nr6Nm1XIIOQDKDXdwwDPDdPIGvawx6/f43AA/EPWd9GtAzf0CBg==
X-Received: by 2002:a17:90b:540c:b0:2ff:53a4:74f0 with SMTP id
 98e67ed59e1d1-303a9192fabmr9332478a91.29.1743129897866; 
 Thu, 27 Mar 2025 19:44:57 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305170e2049sm670309a91.39.2025.03.27.19.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 19:44:57 -0700 (PDT)
Message-ID: <96a03cba-5386-474d-9ee3-f93a9d81fab4@gmail.com>
Date: Fri, 28 Mar 2025 10:44:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] hw/net/e1000: fix memory leak in timer_del()
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org
References: <551d9eaf-dce0-4cf0-95b1-d2347bfaa1a6@gmail.com>
 <CAE8KmOwQBxbjp4a_-kuv_m8SBbFPLsyzQbdqF2nEHs3nG+sQOg@mail.gmail.com>
From: Zheng Huang <hz1624917200@gmail.com>
In-Reply-To: <CAE8KmOwQBxbjp4a_-kuv_m8SBbFPLsyzQbdqF2nEHs3nG+sQOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Prasad,

在 2025/3/27 20:40, Prasad Pandit wrote:
>> @@ -360,13 +360,13 @@ e1000e_intrmgr_fire_all_timers(E1000ECore *core)
>>      int i;
>>
>>      if (core->itr.running) {
>> -        timer_del(core->itr.timer);
>> +        timer_free(core->itr.timer);
>>          e1000e_intrmgr_on_throttling_timer(&core->itr);
>>      }
>>
>>      for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
>>          if (core->eitr[i].running) {
>> -            timer_del(core->eitr[i].timer);
>> +            timer_free(core->eitr[i].timer);
>>              e1000e_intrmgr_on_msix_throttling_timer(&core->eitr[i]);
>>          }
>>      }
>> @@ -3452,7 +3452,7 @@ static void e1000e_reset(E1000ECore *core, bool sw)
>>  {
>>      int i;
>>
>> -    timer_del(core->autoneg_timer);
>> +    timer_free(core->autoneg_timer);
>>
>>      e1000e_intrmgr_reset(core);
> 
> * I doubt if this is correct; Because timer_del() API explicitly says
> -> /* stop a timer, but do not dealloc it */
> 
> * Secondly: autoneg_timer/mit_timer/flush_queue_timer objects are
> freed in 'pci_e1000_uninit()/e1000e_pci_uninit()' functions via
> timer_free() calls. So the memory leak could be because the respective
> *_pci__uninit() function is not called?

Yes, you are right. I mistakenly assumed that there's no way to reenable a
`_del()`ed timer. Thank you sincerely for pointing out this. I'll check the
usage carefully in other occurences.

Best regard,
Zheng

