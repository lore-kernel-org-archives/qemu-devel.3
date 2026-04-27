Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ABAFF8865
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGE0-0003ex-Vp; Mon, 27 Apr 2026 03:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHGDw-0003TE-Cz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHGDs-0007JH-5w
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777274257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uk8d9EMVQtWVf67efSvBgK3JNyuocaGTFDZy3XoaMBo=;
 b=Jg1T6WuS6Op9mDoOWkb2GutXJOR2k3SxdFEW09D5ujvVPgNx83HPkZWzuPPPcGttdBGhLg
 HzMB/xfERyaSKnPsRQi8uMVqRJFY4t9hmG95qMAuO6nPG/HcOJ5JYzsVEtaNmlBHDiFAac
 mcH/wG56bvYy4EiTEiRCLgiHHahhJAQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-yaFk4orsOTGP5Qqpa0mTlg-1; Mon, 27 Apr 2026 03:17:35 -0400
X-MC-Unique: yaFk4orsOTGP5Qqpa0mTlg-1
X-Mimecast-MFC-AGG-ID: yaFk4orsOTGP5Qqpa0mTlg_1777274255
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eaee67d1afso752601485a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777274255; x=1777879055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uk8d9EMVQtWVf67efSvBgK3JNyuocaGTFDZy3XoaMBo=;
 b=e8UQDYLUmkRa9LbaZDnJbJ4XWzQFZnBLglha9G/s1sCh35bb+h4SNoQEyw3/48Q23Y
 DuBmudUQnesR7fKeB75p4slCDNgGdL/+PuvXblEnPp0Ii8IUlMAJvhRQ+7N2eXroFv1v
 ORn+SGv7/BQ7zxYGuRMzoCtY/l/VMlxHuFDI5ClP/aEQYlZL0r4NwZKY1hB2GD9w/PmI
 W/Dp3e1iRZAkZtIZsXXiGiIlPWmpmNbDGbZbVxTiNAMOzr4K8xFvKdMg5Iks6ZlUfl40
 MiMJONupMd4BVHhrozV/AeFhtSNhEMgvuH3v3vwcd2IIKb/g9gKrjqiOP5NG0TxV1rWA
 gnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777274255; x=1777879055;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uk8d9EMVQtWVf67efSvBgK3JNyuocaGTFDZy3XoaMBo=;
 b=UA3QXfLwg/PThmWifdR0KaLhdv9yMgBSXZLUD+h56gMV+569DV4j5CwupYxy3cdvh7
 ZQG+eOzvEVPGsxYeosWd6YjqNtoTx5GFQcEvwj1ysB21V0XsiSOnGzJP5jCPB0+pQRoh
 PLROB54mNSUv1bBrkeAOl9/LYEJUAESH8/j5stI6/XjQPCtDKZq4k099pp4SuNvPIa70
 9T7Wri764OHHUyH2nHGS3Ff3mWow5r5wxkAqUKVgMpVAz/fUGUV16qaw9B/HbWxN7XEz
 A4DZvtNjcSuReyp0b4gmBdmoVF2n1rWuhRW//M3vLrdVItww3oiFk85FoKpUJl0ftwSB
 Fg+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+khHM7gv074G0JU7De677RHad2Ca4e5fUbdBOIAfTkkoxi4Rt7VOJ7zgvmkqDz2eIkJbV7cJ/YCYzk@nongnu.org
X-Gm-Message-State: AOJu0Yzwo7zhENMGwSI/iYjfr8WMJNOVyddtRdZK+DZVvf9K0cvdSEiq
 ytBro3UwIbfCgmFsgUTnLgqIobFqoR/l8XeBuTM7esokvHlu1RvJTmCVQ3K6n7WJErP8sioSZmD
 VYQ80ZeKijkXRda0GrkB5HesHsSwEPhr44F8zeXW0URtWF8x2IQoVLa2z
X-Gm-Gg: AeBDiesDwrkNNCTkvET1FVBmCzrSGHTtktn67MrtYXUuuc3YOAc0g/tudTWvnPQFICX
 iKh+X5/GZ8ENYWpNLMFijT8jifvr/oconFikq5Ryj/X566dBaSmFKC0VctyTVn4tzYqeLjxbkaz
 BI0pQTwJsBbdYBUNh6tb6zkZe3J36blJe1b86fb+59f2QnyJ6oaeTZh/E81VABF9WKu+BpRq0Hu
 nJDqMP9jKtgDvSX9au61GoKWLu8PUXT9au0XeEMfT60ZKfswIcNIrdUz5yei0lN0k3psr+Kyffa
 rS2UTY0DlmOq5jTUyXW9/TK93N396xSurgwabAH05IslB8XTnISqTYVG8XhjUtucOPz42Udb3pe
 uwkwhpseZr5Cevna1y+gAWOJIrR8SxA==
X-Received: by 2002:a05:620a:2989:b0:8f6:4a8b:f75c with SMTP id
 af79cd13be357-8f64a8bf780mr296207585a.55.1777274254602; 
 Mon, 27 Apr 2026 00:17:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:8f6:4a8b:f75c with SMTP id
 af79cd13be357-8f64a8bf780mr296204885a.55.1777274254124; 
 Mon, 27 Apr 2026 00:17:34 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d3204cc6sm2588740385a.0.2026.04.27.00.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:17:33 -0700 (PDT)
Message-ID: <a7e8ab0f-dddf-407a-ab1c-8f465734d238@redhat.com>
Date: Mon, 27 Apr 2026 09:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: First-time contributor looking to work on malloc/calloc cleanups
To: Lucas Cardoso <luc.fast2004@gmail.com>, qemu-devel@nongnu.org
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, Aadhya-R
 <aadhyar.cs24@rvce.edu.in>, Peter Maydell <peter.maydell@linaro.org>
References: <CAHMzB=iZB24QqPwcMjJrfp4GjCkKKpa_0aG0Qx=YOFGUxab8Lg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAHMzB=iZB24QqPwcMjJrfp4GjCkKKpa_0aG0Qx=YOFGUxab8Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/04/2026 15.26, Lucas Cardoso wrote:
> Hi everyone,
> 
> I am looking to make my first contribution to QEMU and would like to start 
> by tackling the remaining cleanups for the GitLab issue: "conversions of 
> malloc/calloc/free to g_malloc/g_new/g_free etc" (https://gitlab.com/qemu- 
> project/qemu/-/work_items/1798 <https://gitlab.com/qemu-project/qemu/-/ 
> work_items/1798>).
> 
> I've checked the codebase and saw that some files mentioned in the original 
> issue still have remaining malloc calls that need converting:
> - hw/audio/fmopl.c
> - target/xtensa/translate.c
> - disas/m68k.c
> - disas/sparc.c
> Also, this file still has a calloc call that needs converting:
> - hw/xtensa/mx_pic.c
> 
> I checked the mailing list archive, and saw that someone else tried to 
> tackle this issue a month ago. They made some progress on hw/audio/fmopl.c, 
> but it seems as if they've stopped working on it.
> I would like to start working on these one file at a time, starting with hw/ 
> audio/fmopl.c for malloc conversions and hw/xtensa/mx_pic.c for calloc.
> 
> Following the 'Contribute/BiteSizedTasks' wiki page, I decided to send this 
> email. Could you let me know if anyone is currently working on these 
> specific files, or if it's safe for me to proceed? If so, I'd appreciate it 
> if someone could assign the corresponding GitLab issue to me.
> 
> Thanks,
> Lucas Cardoso
> @lucasac00 on Gitlab

  Hi Lucas,

it might make sense to CC: the reporter of the issue (Peter) and the author 
of the previous fmopl patch to synchronize. Otherwise, mails like this 
easily get lost in the high volume of traffic on the qemu-devel mailing 
list. I've added them now so they can join the conversation.

I'd suggest that you start with a patch that tackles the other files, in 
case Aadhya still want to finish the previous patch to fmopl.c.
Seems like there is also already a patch available for sparc.c:

https://lore.kernel.org/qemu-devel/69b6addd.170a0220.2bbc48.65e4@mx.google.com/

And for xtensa:

https://lore.kernel.org/qemu-devel/20250730062142.1665980-1-frolov@swemel.ru/

... so maybe best if you start with a patch to m68k.c ?

  HTH,
   Thomas


