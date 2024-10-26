Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F9D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 06:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Zu6-0000tl-TN; Sat, 26 Oct 2024 02:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4Ztv-0000nA-Mt
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:03:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4Ztt-0002EH-Fp
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:03:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so22345655ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729922628; x=1730527428;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdrpDgFQELLgRYtEd9cU0fpp9xdUXDgn9nxPDowdiGM=;
 b=F5ZQcB2k/FTXKK3egHsG7HXpd0fWAeNaULXD0zkfFOH1sgtJmyFssVjmg/TP5ynYfn
 eDbt9uDFpCVH9qVMXmBUp8d6EACBI58cHLjeNVDkmk+9KtIFNadyreZ3rfmnA54If6qY
 Vhaurw2O/dmUoYknf93Q8UGTTFPsAnhx+NHhe5OUnYBIxpppwZM0b93naSxe749VmNl0
 UEf+5aafLD9F9IqA+IQ7QOhqmGN+O175BjHNPBWHf2eHGL04+r8LHN36KomxkMf/qR09
 CbAuQmn0Y8S/GLmM1zzXsvp3jNOwgZ0VAu5yQ479RqO94hFArQuxogRv+xSCh/yiB9zt
 1huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729922628; x=1730527428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdrpDgFQELLgRYtEd9cU0fpp9xdUXDgn9nxPDowdiGM=;
 b=dPI3dhS25/l4Lxl7CSskuBLDc26xT69wDNWTQ5HbX4YWkvH5WNKwaIwFSgUppsG0EW
 U36gEdDvKfGHAdAdCgOt+UEvFJxpF26BJIGEcbMFoVpMzsdSIozDUy/N7l+aw7Y5v83U
 FH8EvKwg15X30V0CPcwl5mwwOYYMX8KziyePFLZ74G9POIgaZAA9i14T0ARVk36pTKoJ
 IdfrmAKrFujFVooMw5uxydJNzsMg2VmFD9ABU10AUP1gnF9sB/VyorwLxyQBLKy/8C4f
 DD5LDdDdxhytl93dOY44lYjvUAOTG1upiGXfuQ4QOJq00OwZXcV7BlnsOW1s03kcGJFU
 Wdrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/jjZhfTc2T4rrAePY4EskIKzn5TELkPWbAZHyQ4TtGwdmRtlkaQoitIkG9TydQTR91Utt1iSARvhd@nongnu.org
X-Gm-Message-State: AOJu0YxHW7tr2ixfQKVtUIVrR0bBdQi2pq9RRkFQgd2stR9J53zMrKd8
 Zjt+JBDPYDHOYX4xJWCrqTYdDx29GqtP0j1jVM19rOj16Af61Qlxe4tCB+iWEWo=
X-Google-Smtp-Source: AGHT+IFVa82XYKjg/KppP6komkk7JpiMYthK6NfH2TVNLjoqRG8IWVGXTb1ipHMweCxodreOOv+wLQ==
X-Received: by 2002:a17:902:e843:b0:20b:b39d:9735 with SMTP id
 d9443c01a7336-210c6c823dbmr27264935ad.54.1729922628175; 
 Fri, 25 Oct 2024 23:03:48 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02e615sm18499695ad.190.2024.10.25.23.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 23:03:47 -0700 (PDT)
Message-ID: <c8e5f926-7f0d-4ced-886e-d9a7538bf8fe@daynix.com>
Date: Sat, 26 Oct 2024 15:03:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] hw/block/virtio-blk: Replaces request free
 function with g_free
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-15-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024102813.9855-15-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> The virtio_blk_free_request() function has been a 1-liner forwarding
> to g_free() for a while now. We may as well call g_free on the request
> pointer directly.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

