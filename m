Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA19CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArmK-0000oP-MY; Mon, 20 Oct 2025 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArmH-0000ns-S7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:26:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArmA-0002CG-1q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:26:29 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63e330a1360so1434245d50.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760973980; x=1761578780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbRc2Y50tjDDzcqSbLJtri+I8B9LM+txZdnW1HHpKJU=;
 b=cSDym7ZUgnue69p9+QrMRtCvDuRTv20boZmA5zWRDoTHp7ygOBVcUCm+wGzBrmcD0A
 4zab9xAyS8fbwPZo7LgvC0Mgjd6BspPXfeGg4j+BFg3KigrzPo9JhPezekp7g/JZycj7
 DrNFSW4lG+qanDZrUXfTLanbmNR/KCxsC8d4rR+iIQOAZv+wGpEoVOFdGHQp4Bv5+imB
 +xjU6aU0pXT9L5YP+yv7iiIUMcpmR7wP0Fyl+5U6UB3tEjmoqmv9wWe8WHcDNDnjpSJM
 s84oSL/8SvugFnTW7HMF2kPSGudUupB3rZUn0Fu5AjUW++JXzj9cBpaz1Uk3R/wJKj23
 Fbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973980; x=1761578780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbRc2Y50tjDDzcqSbLJtri+I8B9LM+txZdnW1HHpKJU=;
 b=CISrjBzKALHFPpRnjoNsS7/51e8QMbcp91VM1svGmw8PQjKHnsboh7UEfOsruYyexl
 qzN7+mrdZaeJRCRHDV3VowLli5g8bPKimdop9lVl2iE/rEI64YAYHuWNEvogI4RwxT1q
 PDEvUsogkWGlHiBxSYzol/4I9NLfFBoMhujoH1M2kUtqED5KxTwa/7WrZdWU+aZM5pIc
 GPsd/YpvZYualNkue/FS950vV721f+YDrCBB9NL4C+dBF3gkYRRAltTppJvHSIuAgJsj
 UjRBA4F5diB1WbFh8jnJ37RYyuZQqooAzjQOaXWmvPQPi88RRJCpAOU0mne06NWVWE2k
 cDTg==
X-Gm-Message-State: AOJu0Yze34R1liC/rcQkBgoQE89Dz4Qvt4VCT2ynPrBOGZleIu3S3rt/
 3Y/hQISq6RVcx4yHEeo5krlpjYGkEjiCB6hGDUNLbMn/iinSqpqmwuhG76GwQoet6rsQo5V/kLb
 yIgZr22OdU4aUxKEetgMRyEJkRUOE17MXp9OQofZzJg==
X-Gm-Gg: ASbGncuUErwSz/RwCWLRRJZleiryUFz2gEujQjU3WOw9Cafuw7rLdBaxZuaarDFeZpK
 kfn50liApy6+ugTOBXF1lD2Xxcflp1dFqn71hpbbSs5NSPhM9IPNnS/mZiytagYh8oNq61GshBP
 SxwmLAfe5q5RVIJOklAJ6MHK6H7DveZyClJUFyFvsbzFbQhmafZ3BDRXG+p8c8uYyb1nYGbXAJ9
 riI7w5J1uV+hZFLZ0LXdrAe4A51IIHILIjNWa0O+aTGfSur5Za/rCQBwbAUZof4eMtnHrJT
X-Google-Smtp-Source: AGHT+IF2lA8mPn6ikyx1pTs5VK8SppYjXpbp75WufW7LAzrXWk9WWWZdNcE/2soNUTBUebAdU9o3mmsUK7q4a+t5yWI=
X-Received: by 2002:a05:690e:155c:20b0:63e:1a76:e9aa with SMTP id
 956f58d0204a3-63e1a76ecf5mr8611220d50.61.1760973979616; Mon, 20 Oct 2025
 08:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-5-mlugg@mlugg.co.uk>
In-Reply-To: <20251011200337.30258-5-mlugg@mlugg.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 16:26:08 +0100
X-Gm-Features: AS18NWCeODjMrbj78pvHr_w-QmC5kHqgpOAfPSjy9Qxvz-fxvkljpnBl7ZoFhKo
Message-ID: <CAFEAcA_mLnE5kEBMkpq1fNNq00ivND7wvRyBpxfxWpNSYd=PAA@mail.gmail.com>
Subject: Re: [PATCH 4/4] tests: add tcg coverage for fixed mremap bugs
To: Matthew Lugg <mlugg@mlugg.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 11 Oct 2025 at 21:20, Matthew Lugg <mlugg@mlugg.co.uk> wrote:
>
> These tests cover the first two fixes in this patch series. The final
> patch is not covered because the bug it fixes is not easily observable
> by the guest.
>
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---
>  tests/tcg/multiarch/test-mmap.c | 47 +++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 5 deletions(-)

The test case itself looks good, so my review comments
below are just minor nits.

> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
> index 96257f8ebe..64df694d1a 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -22,6 +22,7 @@
>   * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#define _GNU_SOURCE

Why do we need to define this now ?

>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> @@ -36,12 +37,12 @@
>  do                                                             \
>  {                                                              \
>    if (!(x)) {                                                  \
> -    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
> +    fprintf(stderr, " FAILED at %s:%d\n", __FILE__, __LINE__); \

I think that this is trying to fix a cosmetic bug in
the printing of error messages: the tests each print
some line without a newline, like:
  fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
and then for the passing case we add a space and complete the line:
  fprintf(stdout, " passed\n");

but this fail_unless() macro is not adding the space, so
presumably we print something awkward like
check_invalid_mmaps addr=0x12435468FAILED at ...

But we should separate out this trivial cleanup from
the patch adding a new test case.

>      exit (EXIT_FAILURE);                                       \
>    }                                                            \
>  } while (0)
>
> -unsigned char *dummybuf;
> +unsigned char *dummybuf; /* length is 2*pagesize */
>  static unsigned int pagesize;
>  static unsigned int pagemask;
>  int test_fd;
> @@ -439,21 +440,56 @@ void check_invalid_mmaps(void)
>  {
>      unsigned char *addr;
>
> +    fprintf(stdout, "%s", __func__);
> +
>      /* Attempt to map a zero length page.  */
>      addr = mmap(NULL, 0, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
>      fail_unless(addr == MAP_FAILED);
>      fail_unless(errno == EINVAL);
>
>      /* Attempt to map a over length page.  */
>      addr = mmap(NULL, -4, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
>      fail_unless(addr == MAP_FAILED);
>      fail_unless(errno == ENOMEM);

Can we leave the printfs for the existing test cases alone?
You can add a new one for your new subcase:
       fprintf(stdout, "%s mremap addr=%p", __func__, addr);

> +    /* Attempt to remap a region which exceeds the bounds of memory. */
> +    addr = mremap((void *)((uintptr_t)pagesize * 10), SIZE_MAX & ~(size_t)pagemask, pagesize, 0);
> +    fail_unless(addr == MAP_FAILED);
> +    fail_unless(errno == EFAULT);
> +
>      fprintf(stdout, " passed\n");
>  }
>
> +void check_shrink_mmaps(void)
> +{
> +    unsigned char *a, *b, *c;
> +    a = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    b = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    c = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +    fail_unless(a != MAP_FAILED);
> +    fail_unless(b != MAP_FAILED);
> +    fail_unless(c != MAP_FAILED);
> +
> +    /* Ensure we can read the full mappings */
> +    memcpy(dummybuf, a, 2 * pagesize);
> +    memcpy(dummybuf, b, 2 * pagesize);
> +    memcpy(dummybuf, c, 2 * pagesize);
> +
> +    /* Shrink the middle mapping in-place; the others should be unaffected */
> +    b = mremap(b, pagesize * 2, pagesize, 0);
> +    fail_unless(b != MAP_FAILED);
> +
> +    /* Ensure we can still access all valid mappings */
> +    memcpy(dummybuf, a, 2 * pagesize);
> +    memcpy(dummybuf, b, pagesize);
> +    memcpy(dummybuf, c, 2 * pagesize);
> +
> +    munmap(a, 2 * pagesize);
> +    munmap(b, pagesize);
> +    munmap(c, 2 * pagesize);
> +}
> +
>  int main(int argc, char **argv)
>  {
>         char tempname[] = "/tmp/.cmmapXXXXXX";
> @@ -468,7 +504,7 @@ int main(int argc, char **argv)
>
>         /* Assume pagesize is a power of two.  */
>         pagemask = pagesize - 1;
> -       dummybuf = malloc (pagesize);
> +       dummybuf = malloc (pagesize * 2);
>         printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
>
>         test_fd = mkstemp(tempname);
> @@ -496,6 +532,7 @@ int main(int argc, char **argv)
>         check_file_fixed_eof_mmaps();
>         check_file_unfixed_eof_mmaps();
>         check_invalid_mmaps();
> +    check_shrink_mmaps();

I was going to complain about indent on this line, but the
problem seems to be that the file is incorrectly
indented with hardcoded tabs for parts of it.

>         /* Fails at the moment.  */
>         /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */

thanks
-- PMM

