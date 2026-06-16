Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C3BCD98CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLif-0005de-5m; Tue, 16 Jun 2026 00:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZLiY-0005d1-W0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:48:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZLiX-0000P1-A7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:48:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso30309325ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781585284; x=1782190084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XP41/zPWtx24Waa7WN4pze6KNOBrY/fHGcoRrC6BQ+8=;
 b=Jv88NmicGTHULH6rxeCDLYjK3FgyP5gEZsEileuTzR1uWYstghgrh7Eghq72Lozqh9
 +vbLY4OUEvvwWZ7AmGKmT/FFmUyvJMkvjn1m1ji9NrwO8QbQV+Hwhjil8H9AoTgT0tDl
 U+L4UGialqksA/gxypugV/ijxxmqCMMvYwM4YrijSL0if5PioHAjr49eebXLzAWrzH50
 GQrkDWIKbrCE/brGuxGjMqKRfKLL6izv6pBZdqrGissXfoZnHHM7XOWFJ0ykrgyoQCo3
 rLkT2CGVI/wuSRP1QXu80rHm1vdSIKdhv8dgkNhYWAexsWgPNLVkYIDFP5+Y/PwGVUFl
 iV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781585284; x=1782190084;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XP41/zPWtx24Waa7WN4pze6KNOBrY/fHGcoRrC6BQ+8=;
 b=S+VTBKhgYfNE+5EIeuzbksMH+Z+ZSUCAfT6kqj1h7vgrA1iVpDY4kv3PppTFQjoYuv
 WzoybTEYglzS4MSSsCXHW95HEsdthq17JNLUu4ewe/hcOP4vV1IN/hrY2cy48XVpbetD
 75ixVZpxlFac1s7swrdOp4aFKBhcMSU8wItMOPFX5ABrzgFd36XBzwYvCC2IwsIfnX6B
 oh3e2UG+rB5olmMefYcr2zlPApsZGTpvlKjfL/givf6snPkPfGnuQLRKw74ha3S198tD
 71NHEvNKQ+zwFyjebqquZqe+05VN3bH2hGtVgBj0Qvgib74LAHXaT/iS8ouqjbYHR4V3
 LTyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yb8jl9gc677GjpgMxov0l6iuhlKIx8PRqBGAtvIZ5VRKWy5/FJi5CS/GV8S6KAALfSe+zwX4EQzTU@nongnu.org
X-Gm-Message-State: AOJu0Ywze0OdIMhR9Cv8FgFgV4Qztkpb3iCb7L5Y1jv3RwR4HOqN9DZ+
 eKCKGKA88vsHZTuBfQhSZ5gmSYp+LJfnwiwPFVhb7UHStFxyPYcDa/298HkrU0gN1xg=
X-Gm-Gg: Acq92OE/n2EPbW/YceBYiObFn40wd5pyQFoUSG/PpgY6Ok6fEVNVVGNh8N7SqEChRJl
 nOXAQqHCmTw6gwnPnhJ+CjAMksCVYW000sKxHszCucs5KdmEvjbd5hm/7V2CrmI9XCpGJajEwE+
 LruImdnWKQzbtCG0z1hf0uGfMH9XLV7d/47e7iDi55meqDwNCa7yWH/UmZafIbLcPdsnWXzL00I
 MPiUQkMvHL4dae9ZmAId36cYoBOVjjIVmpUzVLBrGHMoF7SHqO9fsAvPCLmxQx9sBxuhDDLhrpb
 uCY1OkKHlvC6r4LYBLD+7nUZkcsiezfzjZCOoLCH5uemijpYPR2ddujOVTKp3rEtX3iB0Qe294C
 Njpm4/levSVnkjjQseRMTwz9OBe13jH164AIQDkD5MVQMteT4T38ABJU1Z3G8xfyqSVAPPsj65m
 9vizUVYHdAXJyhy2Yu9D88b/xbwpbW/6TH0rgG6fM1YQtmRxbEwGhPZNVSvfCFIu0Fyixi
X-Received: by 2002:a17:902:f54a:b0:2c0:a746:7aff with SMTP id
 d9443c01a7336-2c69a186b1amr21202235ad.24.1781585283627; 
 Mon, 15 Jun 2026 21:48:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ce89sm118135195ad.57.2026.06.15.21.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 21:48:03 -0700 (PDT)
Message-ID: <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
Date: Mon, 15 Jun 2026 21:48:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260615224658-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/15/26 21:23, Michael S. Tsirkin wrote:
> B. Also on x86, I do not see why we should not use memcpy for large
> accesses if we can. Better perf.

We have an example where memcpy writes to the same location 3 times.
This is not appropriate for any host.


r~

