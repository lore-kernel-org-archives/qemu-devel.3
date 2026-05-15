Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D360CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy9-0004F2-Nn; Fri, 15 May 2026 17:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy2-0003PL-Tt
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:11 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy0-0003DX-J6
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso337565a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880067; x=1779484867;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NY2OqudA4Z6H0iIcF7VAVXA6z448HiczTLUV6Xd88TI=;
 b=jTErZEbEUAiKkqX7R3ZJ4EilPcOGEFnQU8xCwhWQhUXDr9tMvcgRWsHz5LI7+UEIPD
 2zMEmzqd0ye8SDht1hsFETdK4WwZPvphrLuoGIaPlQRiJuwbsediwFOVx2Rzl5Er7SFv
 ApOOdC40EWgaRYMfpv8DqFtcI1tQy9fyWF/P4/TCtMAiTRvbG7SYQK0fUhOblPCW/Dqn
 ItSOfGiPUfUsoV7ztoTAEIA0Mfl8KfXUK2go20LYHHFVEe6g2Tp18hVSIqeBVwKWzgI8
 4qOvpmRKV+M/5Nq5Hoo/j4sAKdFwC4GZFLHbNbiRJjkslq2MACl8K/eNvhZX8/n8T3Ua
 2nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880067; x=1779484867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NY2OqudA4Z6H0iIcF7VAVXA6z448HiczTLUV6Xd88TI=;
 b=N6tmhXoaC//EUHW1r3luk3MXHIUnXdPoI6/QZhjtnDqf7JpLPbPPZrY9a+ilpSuqBc
 t/UHOfSY5+3911UJCkQWT+YRsH/rr5fQvVlzrd/QTaWTbv1pjD2iKCPhXNcRvufSGydk
 CEVjXbmCQ+IoDPg9o+aUspVV9hBGPwaAtWih9wKulmCUP3TdKRcXrpzyA0VZUg1mLbkD
 RzLYKsbqh+m3Sy8wtR21gmU+ZM0Sdr+ssY7y5u3YXNM+WSNPpW2qIxSJ3hpquSlVo3ch
 b9kTHyNwiJDYkMd0DtVkL0wJNmpDR6xCZxUp0DUkszDjEhHWaC1I5zZf4Jqr+dwoYu1a
 scGQ==
X-Gm-Message-State: AOJu0YzX1eGbmYjJZ5oi6mNRS8GV5phvikx5GyKdDsu7BIkMBLR3wf5o
 J+dOzbqShp5+F3RosMHdHJoZyZRQ2wai7gccsHg6lS8MSrjWBaaW9xtkD1soBOSOV72RdhuYBSh
 CKffEZf0=
X-Gm-Gg: Acq92OES9dF6dbuO/3Byl+mQaztKNp0UEOR6G9M/b6WyYGfrO7SW+JT0rpbQJFeSD+o
 lwjF4PcwGWyQh9QPjqA0aFDhn3+INz5Vlt/DYAVeM80zA86LeMNJpsOzOX9cP1ErqVtwYNobSvO
 4wh6vU3iRW07HQ1FrEJIFfnZ2GxWZ4GFZowcu0K1lnuBjAEwHWvHFXepTbcO2XTVWlQYEi7L5je
 VG5uNTpUf+5vKY6SsAtKjT+uDtZ3MHvE//1YlzHU1RbXgEhbhIXwxyvn7R3Apk/n/apVz+TKiat
 bBNhMY2d3R3xKrcuqVd/x9iRu2plxZx1kZZ16M3ZLuwGm4iVugehli2WX6hmbE93Lfbx9ujBDYS
 311R8yXOGQdivN9QpAO04B9IfKeEv7Ymh5oxWXcD2YvMbGq/hPXIFuLQpNZfKlJhdb+XdWbu+bF
 ToVkJcyZFVwQ==
X-Received: by 2002:a05:6830:82aa:b0:7d7:e844:7f4e with SMTP id
 46e09a7af769-7e4f2bd75c5mr4021296a34.22.1778880067599; 
 Fri, 15 May 2026 14:21:07 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:01 -0600
Subject: [PATCH 62/66] bsd-user: freebsd_rw_wrlock needs to
 unlock_user_struct on this path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-62-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=rhRfOt/9sDKD5ZAVEtT2L9CyIfY2YRZQwnGS5qh5jwQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43odwgaxrwrrGhDG8dpG31tHujmZJD3VvFef
 cFnRsZYDBGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 ABGrEADfQAhtGZy4063tIBxR9HKLGLzzrgoh3Pd9NxvWEP7v0neJrNrghNsiI5CZC1qtyVI7fEd
 Gw2R3BKeKRRZiD0Q20RroOQdoNUEOqvxnbeP1fvW+kv1zCPXHo3nRZutIqhPw849My/M8Chi9Ij
 GDNEfiesjdsRI+u6oVst+nM8pqwNweJM2i8kTC8HRjZpFf19/gZP6jHG7IAttIDxoxIHcDeoadk
 8tNf6uRTGSXE6c0G9Q0on+Xc6A3EgR4XGiTG736RTgzwVMC5eoyfrVUka1oaaxtyORpcuzJPwjh
 aDGsHC3iuYDzp17QjJpYtsX+0JvBRsI5ATWZ4+vaF7Zd/kLGle7PJiSpIJhqfCbldvU8Htc4kr7
 Uped7ndvKEEPqafC5+LG6Eg6W2A/uvLxYd3bJU1MpUH6dXmVmbW0AjQEFB13kcg67p0NWos2nZs
 FiUABdAHwovbE21w6bJCxeQAysKV1ptgdKK6e4nD16RsNYEHDMhwAIM7eSmXWxbbxyo1VzOvaGa
 5hYgSEBoE3dQd+tAwWCmggcONJVC5sejb82hW/zdZk+4JrbUBvvHSVBL1wCLW82kliwa8CnMcql
 WvvrjXh9nDE0nbd3d3WxJ9O1BlfODCTm+8hAdbk9mLe+yc2a5E20IbiZ6no1irUsvbUM2xyuTtT
 gknTm6amH0iZCPA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

We need to unlock the struct on all the return paths. We didn't on this
one.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index a36c5ceccf..86dea0aea2 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1350,6 +1350,7 @@ abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
                 tswap32(state));
             ret = get_errno(safe__umtx_op(&target_urwlock->rw_state,
                 UMTX_OP_WAKE, INT_MAX, NULL, NULL));
+            unlock_user_struct(target_urwlock, target_addr, ret == 0);
             return ret;
         }
         /* re-read the state */

-- 
2.52.0


