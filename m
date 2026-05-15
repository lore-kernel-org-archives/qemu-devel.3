Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E42CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy1-0003BL-TZ; Fri, 15 May 2026 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxg-0002h0-DZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:48 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxe-00036Y-PW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:48 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so344440a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880045; x=1779484845;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LliE3/htyGU4OjwLNQCoU+MeAEXhlDoXWc5crY4U9k=;
 b=uqWtvhSZWn7psSwzoLrKriYCn1ELgF8QZDybONsMNHsmU82MQkcSMqwKRrAwzxKIu/
 vXCWsiH0kymwrYeAuy+L2yHg76UiQRMJnA/rYb+tzbW8O8w+mBNeKrUr5eY1gkZF0aiD
 7tGZ93rhQ/vf619xTFJUGYbqXnb3gBPF1sV2E1cYKmd50ZMnFw8HKDePmVntUGrNnddz
 DcerPTpFqpkgtHEeCfCKikvXM7QaEHR8iHdKzSteVL5Lz/Sl01q9QJuYynZ1N7W49PCe
 gA9iGe2PO+Bi6QwqiY4ZK6d4iIgnRVwwlou3hCPF6Q2osp4oLoDbv4CtCbWMvpDHTFYv
 maBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880045; x=1779484845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0LliE3/htyGU4OjwLNQCoU+MeAEXhlDoXWc5crY4U9k=;
 b=fWKy7CT2tW3B+7fZ/OLjo3UD78KcIGZyYEPOmdPtLslO8tvxKVmH5sl1tBs+d6OYCG
 QSJFIAHGoyiHtUEQ2PsOipYHQPaaeHJ/Zs0ByPjf9wV92ymCtRE3NmZ9jkFz1FHTubZS
 O4xM6J3hUeXj2BiqI1AFgFnbwnei69/zeWIOzc0Vw/ZVc6+Ukc+2/O4gfZypbSBTYnEr
 fcG2qQ6Z/2BSpMBHZ0hk2uKx7kmtmCvs2V1c2lrVfb17FbGJ0dQUE1GhqqHZUOQ5D3U/
 VARvQLxHpRaiPKmk7yLQyhHgP0CQhz2WWajGQKBArqd/189uqjZLIbVGRDxS8GPTKzRi
 PnRQ==
X-Gm-Message-State: AOJu0YyFpX67zb3TKepxj6TvY34RZn/QpqU8/PfO8HjHX9Ipdxh4IjXA
 81NQaN0dvFmm+8H/+PkM5ms5SNnWjrWEeTBGtD5nXtG5vlVcKTaWykDAcKzwTgP9xESElZA/w52
 fVVEu/XA=
X-Gm-Gg: Acq92OHyTBrXu0GWBr8ZEB7moqxOHwuG/WoMfQ5NpIHqf9ayhrod6iAnpKBzUxd1Eq6
 I356KxVT+Z/6yDLD81eMI41QOtoiBGgrg9CnY8kBVRGYpLcLN/W9oFtogsTEHipVx2FwTqD8QbQ
 vFf0itr/mT5bA7SeJTDYlw+KIqP4Gg1OfXH9kXpKM/XAWfFIH9XiuR6Xb+nzXWXACp/p0dJvbga
 LUF4IiSNzkbt53KbCjcicaUqMgzhuA1ceBMDWGQaBHyGuiog/jUJUjg+ZKLDhd5B2gu2hoGG/1n
 uDZLWa2wRvzNswfO6JqUBqgHXfqhrR3iXzMqHM3v6sbwQbQcX9IxbqPRO5BaryXKL9rdxXAfwhW
 PzAD4Uyux3lNtsq8cnRFq2U7LEIiQfgYntxmPXnRahtX2tAhQVjTp4Av3leWGizyBP9aq4wpeeP
 i4lN66lCdaTg==
X-Received: by 2002:a9d:6ad0:0:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7e3f1014018mr4400651a34.5.1778880044976; 
 Fri, 15 May 2026 14:20:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:40 -0600
Subject: [PATCH 41/66] bsd-user: Fix kenv KENV_SET to not write back
 read-only buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-41-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=3EM274dxNtc0cbsRdm6rHs5WLgeCOj1JwA4lGKjXEKM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43m7yuP6a5ONQ0r9uswWBghLD0iZe52zdzfw
 QtUpbArjDaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AG0QD/9D8awpbE5JzYhOPvye9RGdSeC6AEt/kBVT0NKVqFwo+j/FCRAfEjTOVJS2ni0nfycx/kc
 /llFKPmguMkfasGKHxifOjh1Xd/uc7hDMxGQ9yxLchcZUGC9lPq6axcHve7vtQCTnPj33bZk/EK
 ADNu6av05BgK7h9RiN1JBJ4ijHWOkAwBtmax4qrqBPjrB0BGz3ETu0LTrjDWRtGS8MWV8tMYIYh
 X7JX4hEOACBQnDRkbgd40ccYdl2wAQT2994SBesVlyj88NIjQrdtSxEMV56jiUQ0SxLp6kSq0qn
 4jALmBHS+ff4L5QVueydBg+/T3JytlZJYmZ++6JPSBZFTKyqQuzlTFkPqeso2ac4kgT+e+U0yvQ
 un7RdVouHlHRT3BxbNkGf5zy1IO4gbslm6OjGMq2Ie5uiA1mqRV9vV2CVm2VYIKf8OV6JfOWkmr
 BnNtUy13akGguznhiWvCUn3DB8uU8UJed5kHsU9730LtfstlbJyah590N7chQcuCWqkotQ82hmI
 Pw9o4Jcj5FSgkZPD+rPLSTFnqSrOiVCkMt4H02ASO3UBK5cfQqS3Dl2Tz1ts8P5ZDJAX/OPtTdi
 vc6kNfRaSh4TwGKaai2U75iRukKaXXdbmNy7vHYr9r6Mhfu2FJYO+pbwSxfgEbgjJoEySLIlZOu
 Xd7fY7k/o6Jr7hg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

The shared unlock_user at the end of do_freebsd_kenv used the
(potentially modified) len variable for all cases, including
KENV_SET which locks with VERIFY_READ. Unlock the KENV_SET buffer
inline with writeback length 0 so it doesn't spuriously write back
to user memory.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 7ee903a5ba..204d8ebd3d 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -495,6 +495,8 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
             break;
         }
         ret = kenv(action, gname, gvalue, len);
+        unlock_user(gvalue, value, 0);
+        gvalue = NULL;
         break;
     case KENV_UNSET:
         gname = lock_user_string(name);

-- 
2.52.0


