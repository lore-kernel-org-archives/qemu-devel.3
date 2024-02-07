Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA7C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXc7S-0006eq-W2; Wed, 07 Feb 2024 02:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXc7P-0006dh-9Y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:13:17 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXc7M-0002qb-Kw
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:13:14 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 0C2FE4076728;
 Wed,  7 Feb 2024 07:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C2FE4076728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707289990;
 bh=9C36JCUHOxmvv48/eXLKpB40Tc5psddPm3fxJcAexFA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=WW+GWpOHZluVpW7nquqXNDdGXQmCaPiRvzxdGfKYKdzRetNa551ecEcdbfUy9UZiQ
 H5O+3xkcgiRE2kRQMx8oyBPqp9qmznUmUJFFg43VBZ0jvYc13F0MXYBOGwwjas9YNE
 UfunDvYZUd5/XClSfW6wFSndVdZp6RrhOkwMVYj8=
Date: Wed, 7 Feb 2024 10:13:09 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/6] util/bufferiszero: introduce an inline wrapper
In-Reply-To: <b2160783-08ae-4ec7-8e49-e493cabac7b2@linaro.org>
Message-ID: <cdbe132a-38e0-1200-bebb-ca0dfc3e1e7b@ispras.ru>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-3-amonakov@ispras.ru>
 <b2160783-08ae-4ec7-8e49-e493cabac7b2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On Wed, 7 Feb 2024, Richard Henderson wrote:

> On 2/7/24 06:48, Alexander Monakov wrote:
> > Make buffer_is_zero a 'static inline' function that tests up to three
> > bytes from the buffer before handing off to an unrolled loop. This
> > eliminates call overhead for most non-zero buffers, and allows to
> > optimize out length checks when it is known at compile time (which is
> > often the case in Qemu).
> > 
> > Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> > Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
> > ---
> >   include/qemu/cutils.h | 28 +++++++++++++++-
> >   util/bufferiszero.c   | 76 ++++++++++++-------------------------------
> >   2 files changed, 47 insertions(+), 57 deletions(-)
> > 
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index 92c927a6a3..62b153e603 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
> > @@ -187,9 +187,35 @@ char *freq_to_str(uint64_t freq_hz);
> >   /* used to print char* safely */
> >   #define STR_OR_NULL(str) ((str) ? (str) : "null")
> >   
> > -bool buffer_is_zero(const void *buf, size_t len);
> > +bool buffer_is_zero_len_4_plus(const void *, size_t);
> > +extern bool (*buffer_is_zero_len_256_plus)(const void *, size_t);
> 
> Why 256, when the avx2 routine can handle size 128, and you're about to remove
> avx512?

(yes, avx2 is bumped to 256-byte chunks in a later patch)

> You appear to have missed that select_accel_fn() resolves directly to
> buffer_zero_int, aka buffer_is_zero_len_4_plus for non-x86, without an
> indirect function call.
> 
> I think you should not attempt to expose the 4 vs larger implementation detail
> here in the inline function.  Presumably the bulk of the benefit in avoiding
> the function call is already realized via the three byte spot checks.

Thank you. I agree we shouldn't penalize non-x86 hosts here, but to be honest
I'd really like to keep this optimization because so many places in Qemu invoke
buffer_is_zero with a constant length, allowing the compiler to optimize out
the length test. Would you be open to testing availability of optimized variants
in the inline wrapper like this:

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 62b153e603..7a2145ffef 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -209,11 +209,12 @@ static inline bool buffer_is_zero(const void *vbuf, size_t len)
         return true;
     }

+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
     if (len >= 256) {
         return buffer_is_zero_len_256_plus(vbuf, len);
-    } else {
-        return buffer_is_zero_len_4_plus(vbuf, len);
     }
+#endif
+    return buffer_is_zero_len_4_plus(vbuf, len);
 }

 /*

Alexander

