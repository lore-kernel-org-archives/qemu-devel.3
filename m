Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD3C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgR-0001ok-R7; Tue, 18 Aug 2026 19:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgQ-0001oY-Fc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:30 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgP-0005C6-1H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:30 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b28d7c729fso298526b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097448; x=1787702248;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7q9MkBLuXipFuADwgZrw+IHPbXMHvop+eYAjY9foRQ=;
 b=RGQu5dbBKPikWZvr3Nc/UHxKDQ4DSbX0zE2kTL+dbhHavQGMIKHMUBAkS1962rOOSd
 /JACASQYsFfz3k+0PgRNkQxkGlr5rEwAtJUiXC/+diZY1L17vQH7ESByWDfDSezNURmM
 JFx4OQRFJQgZf7AdJNBX4FZ9P8xEYt6Vf2bBuwjnVbChHJmbdtcySEMgdmNaReau71U5
 8HGN2ihXDBV90DBTeatN9MNNjncaANAQ7j63YjrxsASaWLCGYbwi2aHTLKxk4Z71kXxm
 dC5QgAvGl+RGu+QeJ40QAie2oP2/bLzt29CbuEWMS+8nct2RLa/RmA5ts/G4D/jUv47S
 OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097448; x=1787702248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c7q9MkBLuXipFuADwgZrw+IHPbXMHvop+eYAjY9foRQ=;
 b=ZFcpIQjSxPrXr66D2VNAQUI++AjvWkqaUtYG5ZzeGeOpCDdyldvZsjxPz3Bn9L5c5j
 GvNYRQhy73N66rs98HmQZEt8z70V+H2WwQLu7G2Jjc5kxDPLYFepj8s5xUA05jsBtTj8
 1GJxQz/cXs+abWegQm2suDnpZHjQzMKNmjieLOuWwgI2Wf7viS7zkNt94SAGVzBPVTzQ
 mK/8ykq7g/rTmAIurIu5k71C9w/xfoArv9O1CuGXwJ2q8EHV45AmtM4/8GZSxwQlei7S
 XZoEFRmw24++i360dQbTXDJJ7UWxqt3D08woIwLT4pQGzjL+dWtlYVkFnf3lNTbA2+zL
 4P8A==
X-Gm-Message-State: AOJu0YzwMKfecWjdQQMEsFrCMmx6yHjs0nTfaZ951o3XoG84Ozbjjv/X
 7oPmhdJrMg/uPyMQiiYIHMVegZla+3cD8ik65wTmJAnP0maaBJkRCnZqz8Kn1+mPr7I=
X-Gm-Gg: AR+sD12vmty4pP4E1XvMMDh+3GzMyOVOaAAeBlnVBlzgzyX3DGW0a6Bi+kdjPaJSH5l
 XDK+GNeYi+yRBWdf6dZJ5kTDWpSytn76pnK188Y+G2Lh/9QtwNG5YWbOj7snkA3yfTgjLXJjBOh
 WqDomTV1P9GjVYBi6K2WmrlNa5UpJ5/aX8K8L2zXZV46RR6eFn6ru7FOyqArdmpzM5HSAuS1ggu
 JeP8CsRUcSwXqe/X6QtYeerIJqXY/XLP5lHS/umtKzLFWhP1uFtM7ty357bvRyRcWvawBSqg1Wq
 +PBN9Ymio/uXImP+r5zcdUeQ2DPKJFolO5mqFf0SHVVWuz9k8UT1WU678YuVPN0BicYovzlSA8I
 MlMbnVOnON1N6MfQKal1y03YTuSXHiaKKXk5g8ZpDKq2V1BFPm25fIIC5zybcG77LRqF3wiETqw
 Zhx4Zjv8PHOlJnWAufoG66hcqbUOXehQCAtbdP/d/WyT0BrXIuIbnKRqrMMg==
X-Received: by 2002:a05:6808:bc4:b0:4a4:866:c395 with SMTP id
 5614622812f47-4b2bcad8a7fmr410098b6e.13.1787097447712; 
 Tue, 18 Aug 2026 16:57:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:55 -0600
Subject: [PATCH v4 02/40] bsd-user: Fix copy direciton in preadv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-2-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7Em3b9ep2V0F8WfpyI+BaZSBFKvOr1ifqfuI5wr1Vkc=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEhlBLnM5MPiYWWc87nzO+VOd5ky45A51D5H
 JdJdwr9c2qJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxIRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDsthAApG2RRuo0TR3dmkPAkbEAdDYcB6oruMg
 9QkckI6HjY/j1p+MP1vx/2+o6LOFXiX2ETJV0/x0oqJgy9JjaTMdkzGO9NElvGcFrxDhecinPu9
 l9kJydLjBxDH359oEBe832Ppjb70ZXkzPrrWOs2BOiqI0FLi2tQ9FCaZPr7arwjdXQhYlhpjwf4
 +WEPdStLyGaTnYyqyn3Iv6WWvkf4QFqQPhPRSUefKpUn5QWUrV5Pz97IDV2VrUWANaltelsgTnR
 EV8Ka8TtkthEE7DSCFv1VTGvvj8+DKJ6PCoNjXJ9nFbN+WwBJ61XaATRLSlwF56O6FrSjQ/kYNK
 wFjOF+nQ9GSVuwxuM1pAonkHX3kaijaSgc2kDqvsIH0RwFbIVBzgk64KwU6108MvHhvDdfb/+TQ
 JedTo0BuexPapIGIwQN2choOtZI5THaHFr4Ud83LqfQVpgDFQiIIFiTaK+vpmKJan1zwseYr0qG
 Sa8oo3VsX0R4YukMQx6FawLZirC/4FLYQCrbpx2pDWaocyk+ah6hBjTBhqn2xRmiqLB0dx9knRo
 OKLT3kK8KoScAxl1fFkMkSsNbES7cD4peNH2PTJYJNboaw3zjJQYypwj0YFV2UVdwCk0CBwhcZE
 g0s3yVpbNNJBh28wcygSpDMDsS1UVjmo9AWhP8UtqyBfsQ/8xdyA=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22a.google.com
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

As written, we copy in the vector and data then don't copy it out, when
instead. Instead, we should copy the data out. pread and read are
already correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index dec59bd80b..7ef9470c4e 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -113,7 +113,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
-    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 1);
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
 
     if (vec != NULL) {
         if (regpairs_aligned(env) != 0) {
@@ -121,7 +121,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
             arg5 = arg6;
         }
         ret = get_errno(safe_preadv(arg1, vec, arg3, target_arg64(arg4, arg5)));
-        unlock_iovec(vec, arg2, arg3, 0);
+        unlock_iovec(vec, arg2, arg3, 1);
     } else {
         ret = -host_to_target_errno(errno);
     }

-- 
2.55.0


