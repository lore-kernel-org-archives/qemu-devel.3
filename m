Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F5ED41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTdds-0003iK-LK; Thu, 11 Dec 2025 05:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vTddq-0003hb-Tr
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vTddn-000393-UY
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765447877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nmgh047vTXzbL2NzUqcQqn0ZNP7gmgaU+Yt4vREzk4M=;
 b=DU38et2IzPe8u2Ay7Pl9oepDQrBFJpaxC9J5EHeaZoK+TboY5zJ3rf0oEqw9KBzv+pJ3mv
 IeoNEMyvtcRAo9V7N0PyRGD8huzlhDNZWRO2z8ielgrwOMzBrMjswCp+2pqcIt7TcHVop6
 zJxfr2SElvnPuB/Ult3kbKFWcQh367o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-963SyqCwOIagIntmCgQ7Jg-1; Thu, 11 Dec 2025 05:11:16 -0500
X-MC-Unique: 963SyqCwOIagIntmCgQ7Jg-1
X-Mimecast-MFC-AGG-ID: 963SyqCwOIagIntmCgQ7Jg_1765447875
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-649729effd7so776815a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765447875; x=1766052675; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nmgh047vTXzbL2NzUqcQqn0ZNP7gmgaU+Yt4vREzk4M=;
 b=IvjPnn4AN4/6q6/Xb2eclL7wtlux2lok1pc7tLEl0TYrnvR5FhV8wjnme527ySMRuq
 E+EGtCSWsxpwsIhMP8PEfhGQGau4NzLYACW8lLlGJw7WEOo+R4GEkbNia1Ht1IwUal84
 BR6cp1mBpa+ZebI4Qj2J6TdHlG3DxGlF5+br/UGY0OGfTAHC5aA0kuf1C6BCrnnMdn2I
 3l/Uydh3nGzbhyTQ8rCUrjasAAogfGu9bSxzs02OuI3ju86aJ2C1AhPnGHroaPbOcymd
 ajKQO0s4x28YSC/9ma5Eq3LGCF+J6HgtOxAT3PQvx+p9DiWM2SfDP/SY4p635teVRHON
 VQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765447875; x=1766052675;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nmgh047vTXzbL2NzUqcQqn0ZNP7gmgaU+Yt4vREzk4M=;
 b=B6jW8etomsSsqhDOotfcMT13jdJOF+NL8LIiuyyNOX4VnAoJBwGNf4+U8TzPBVcaM9
 9xwvI9l67Iwz05DxqY5X783MNCuwftbGireG5MF82/G2xXmTacWcIGYH9mnQqWBTaek4
 Ta2mgFH/IlFYpj7SiG0fDRkA5f26nnq0mUv6Ht/D1bJhXyhmrSDCIAsZXDGH0kx1f3nk
 tsAzY5+YvTfxdf1Vn+MzgtBWjbux7UKUeBqjGkomPgkaoRv/HlJ6nxWbDNccInO2Bcun
 2mYo76ojDMZ0D2V6wWPACSOc2hP/zG2EEXZubSehrT2YEJvLK4rYGKOaUEZC0mqiSrII
 d+vw==
X-Gm-Message-State: AOJu0YwyzUltxfhieHGiNRo0JSia6BOU9RLQhIW78F6BqicqSWVfbmf7
 RJUYb7Kt4ag2tTkZVNyvo2JXmYXL3sXhdLATJ4rpULo8Z/+E7BhyTp93wv3HAQuvjUo0s/HdVa9
 dtuuRYWx0ziFhjjJxSmbFA5WzyK7zGD44QerBuy+ikHnlnNzz8tHtG5ec
X-Gm-Gg: AY/fxX7yALqgaIPSK53te1+1SFjg8WD1RUllshSk4xQW28yMSel0imuaZXtdMgPgQah
 2c2wjCde+hXGVxl9O1SLLbnDSfLPEOTgvErneRKJO9Cjzp4Gn1qyoluRhGQm/0eFdyMAdU6ha1I
 9wBxXuqe+9K5g/zbsHJ3lwAoEDV0pmRz77M/xrQ24O6+LwUKHTnwEqhLs+6NI0px/ftIy3yGOQO
 bwZDfaTuwRrfNbyBHDicMDgsiwkpbY1vvH6iWNuLqVAFBJT1BKFaCAlAUT34vczKvehyCXyjMCv
 x5kjBO44u32Xl1XRbuIw84hf+RaYyYvnu6yqRKFHhi5YC1UuY982WkzfsOLLyB467et0yYg6igx
 HTPxEtcLDXaF419moyy9yyBU8c+BlSNakx4A0JQhYkel82IbQJU8x7/PQssUk5A==
X-Received: by 2002:a05:6402:3806:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-6496cc16e8dmr4273816a12.21.1765447875200; 
 Thu, 11 Dec 2025 02:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL9F2BGjWMptuXWE8ym5gN2gmqMqswdja2gDOQYxkXSnuOw6kLl/3ko+o6V7ALLN+WLcMTvQ==
X-Received: by 2002:a05:6402:3806:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-6496cc16e8dmr4273786a12.21.1765447874682; 
 Thu, 11 Dec 2025 02:11:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6498210de23sm2068573a12.28.2025.12.11.02.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 02:11:13 -0800 (PST)
Date: Thu, 11 Dec 2025 11:11:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Joerg Roedel <joerg.roedel@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/3] igvm: Fill MADT IGVM parameter field
Message-ID: <qlgmkqwjoupf63drmvrfv3qslp3wvrvphgiafnuluayfjtlj3m@vkecklsigqju>
References: <20251211081517.1546957-1-osteffen@redhat.com>
 <20251211081517.1546957-4-osteffen@redhat.com>
 <26ptyaovy6mlbvuzri4v2ea3xhyvdc5elqsau34upvswarrbop@bhtzvxpb5aad>
 <CA+bRGFqnT=Es1GE6w4U2edaJXpDaSV1bhZ89vcaP5TDfFU8a+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+bRGFqnT=Es1GE6w4U2edaJXpDaSV1bhZ89vcaP5TDfFU8a+Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 11, 2025 at 10:24:35AM +0100, Oliver Steffen wrote:
>On Thu, Dec 11, 2025 at 9:46 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> On Thu, Dec 11, 2025 at 09:15:17AM +0100, Oliver Steffen wrote:

[...]

>> >diff --git a/target/i386/sev.c b/target/i386/sev.c
>> >index fd2dada013..ffeb9f52a2 100644
>> >--- a/target/i386/sev.c
>> >+++ b/target/i386/sev.c
>> >@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>> >          */
>> >         if (x86machine->igvm) {
>> >             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
>> >-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
>> >+                    ->process(x86machine->igvm, machine->cgs, true, NULL, errp) ==
>>
>> Why here we don't need to pass it?
>
>Here we only read the IGVM to figure out the initial vcpu configuration
>(the `onlyVpContext` parameter is true) to initialize kvm,
>The actual IGVM processing is done later.

okay, I see, thanks!

>Should I mention in the comment above why madt is NULL here ?

Yes, please :-)

Stefano


