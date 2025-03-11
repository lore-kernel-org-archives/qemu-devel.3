Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD29FC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvO7-0004iR-V5; Tue, 11 Mar 2025 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvO6-0004hz-Mq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:54:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvO0-0000Xb-MP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:54:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso8697845e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683288; x=1742288088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+NbdoBDIcR1jHweEXbc4Ma4qdVpd3aU6BwDB7n+N8OM=;
 b=EyhT3bEMVtszwvomAWzzt4tqiEAaUXv2412vaA/zYJ4VTKwyH6F4gJOKOo/NiC1ZFU
 6HZe4h5XglczMiqnL2jLiePgy0GmNFYwxx64WsM3zYyUA9SUTFLgpDp48pk2bJIel9H+
 DRIKPjjliDOKDpxOq8vwetSaZgcWACH8uoPcxi1gfZg+cIBOOGsDPbhd615QADVwhkm/
 s/mIUFujSmTByvJEWqTy8Yyn+L11XLoxtd2odFcoTWeZhwr6/Fxz2KpO5P7N8Nf56ZRt
 EkiXympwIDGWwmN7o8IZ6jwafv4KISC/uhXmLWXx5hTbgNCPFldybpeCXI69GoSmZdYE
 bzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683288; x=1742288088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NbdoBDIcR1jHweEXbc4Ma4qdVpd3aU6BwDB7n+N8OM=;
 b=Ojm/mZvcQppGmHdHXoomZbTVCaMigAKeDS8DgsphJ2U65lAXfpIo3UXO1U4xt1eAAG
 zL7JRzEAu4LJL/zthEGaVWij0oVNJM1GFKqRC+r3UkZl2lsTZAPzwQcxZqKB+T9eaWih
 /ieDR5KdjbwsVSdVMIIzejRP5+dyduJ+za98Pkq7CvtinIDVp3u31BRIehhNhlOtioLZ
 wY/2eiJSo+77kKIHbmwrwsloE8gDlz+KSHJJN2jbCqL7RnpXc11MjW8gJlvFuATijAdQ
 L+u3/Vbq543Cwuu/VoKdhpnMpWB/H2cUjAS7kWaxzqu18V25VYUM2PNFliHiIJT2VYHV
 d04Q==
X-Gm-Message-State: AOJu0YzgclQljZXamCR6REZ397uQAQJXAlJX+QneG7GZ/iJIHkUelNxC
 +gA3vwUuwQr25OINZIbeh8rTeZo516AicoaFXnsUpsId+xhJOqg77taQoqCALEA=
X-Gm-Gg: ASbGncshh62ZbS/ncqeghkgoSbiB4Knc9KOgpJLxgr+0HSeu8hVdbVcPc7pB5QTtxPm
 FLpWeJAgB3FB4SSwj2T2DNFrRLI+06d5ijS0+W8Ecxl8SRfDdOSq1rKmetgKep8YsuY9N+Sopkb
 Z/GnmAUG8TcBuniyMMim5h9AkT9ani+mnJJ23NRQcN5NzFtH/kcXqpbTBR4aCbuFO04mbzaroDa
 SXN072OjvMDsgGyAR2WvTJ81X8q2R9WKZOrWNZTQfJ8tZGld/JuFoKVx/EgN7pO6PYsXeq+Hu0E
 SQokvSMySyvlKWuYyshTVM6AMJ54nEOYM4JfN+bhQwtU3a5CYVs4Ni2Z4ZJ8PzKEFyf+GgroF9P
 BJjEzV5D6F12Q
X-Google-Smtp-Source: AGHT+IGkHbj2ZNr/Mfwfq8mUReR/77d7syd2mBxKtkFlkIbijAo/Dl9pEGPS+M5qN+oRcpz9vIFPoQ==
X-Received: by 2002:a05:600c:1c05:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-43d01bdbea9mr42698915e9.11.1741683286740; 
 Tue, 11 Mar 2025 01:54:46 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfe61sm17731252f8f.38.2025.03.11.01.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 01:54:46 -0700 (PDT)
Message-ID: <37026d8c-e892-47cc-b2b1-21d36fe856c2@linaro.org>
Date: Tue, 11 Mar 2025 09:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] hw/vfio/pci: Convert CONFIG_KVM check to runtime
 one
To: BALATON Zoltan <balaton@eik.bme.hu>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-10-philmd@linaro.org>
 <28c102c1-d157-4d22-a351-9fcc8f4260fd@redhat.com>
 <2d44848e-01c1-25c5-dfcb-99f5112fcbd7@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2d44848e-01c1-25c5-dfcb-99f5112fcbd7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/3/25 13:54, BALATON Zoltan wrote:
> On Mon, 10 Mar 2025, Eric Auger wrote:
>> Hi Philippe,
>>
>> On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
>>> Use the runtime kvm_enabled() helper to check whether
>>> KVM is available or not.
>>
>> Miss the "why" of this patch.
>>
>> By the way I fail to remember/see where kvm_allowed is set.

In accel/accel-system.c:

     int accel_init_machine(AccelState *accel, MachineState *ms)
     {
         AccelClass *acc = ACCEL_GET_CLASS(accel);
         int ret;
         ms->accelerator = accel;
         *(acc->allowed) = true;
         ret = acc->init_machine(ms);
         if (ret < 0) {
             ms->accelerator = NULL;
             *(acc->allowed) = false;
             object_unref(OBJECT(accel));
         } else {
             object_set_accelerator_compat_props(acc->compat_props);
         }
         return ret;
     }

> 
> It's in include/system/kvm.h
> 
>> I am also confused because we still have some code, like in
>> vfio/common.c which does both checks:
>> #ifdef CONFIG_KVM
>>         if (kvm_enabled()) {
>>             max_memslots = kvm_get_max_memslots();
>>         }
>> #endif

We should prefer kvm_enabled() over CONFIG_KVM, but for kvm_enabled()
we need the prototypes declared, which sometimes aren't.

