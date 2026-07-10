Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACEC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1gc-00075B-04; Thu, 09 Jul 2026 23:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wi1ga-000753-Nm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 23:13:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wi1gZ-0002H3-5v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 23:13:56 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso841884a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 20:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783653233; cv=none;
 d=google.com; s=arc-20260327;
 b=aXRbTV5IgWardCRwBlNs4U7jk/r+7EwYjoI8tVO2MuNzHtPuy1CiFXKDf42ymK0TVB
 kW10izmREdHPqpjQzu9OgEHL23l6XBe1G116VxtGzwGGUSshZHKXuf3TbVUGenh4wfRp
 Sb2BFgzNIf9OAn80l1hv9YqiKr0m+3+AqWtdJwzQSa/CNGAoGfOLeGqJ67OnLZJbUu1A
 iSQuxFL2wQ5EkaqOkAtB/HKkhfxcZ21AZxJ95LzdP1R0GWN+ugpsQcV5lw9kdPYG3qXx
 Fd6m1yzx32FcghX1BAWsh+9Xa4CPrEHzvDAeMqOPgBbzqYBjx+7oi+JRZsnZtpjKcwwd
 mGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PYKRb++/yq4pz0JqrzTO+3wq3EfPyz5dZCeLpHTgzr0=;
 fh=8CgjkvEvD8M3mmnMwgTzaPJFwoqvueNGIKTYPkUT4L0=;
 b=Qt46pnHIP+L2doDBRcoZl5bcDb5n3hdCZl9a3zpvxjnD+O/JUmmXMRE9tanBQsEG3H
 uDogRempP6hGgPccgvuF7WtKAFXpz7gCVkjVwmJS9yJIZh2swdGRLaRWRhdQuFze/7Ua
 fRFsQVyeNEElSH6q6SIonzSjdTqCvy+IYdbC95bAMsKXODlSEUJHbBSi8mSrfxmPqJEM
 X7w3LDY0o6RABTA4aG11ynaZYBNWazkz/qOFKfwflL2Fqk+wz/Z3192YhjRExGI1+FmJ
 308mTeT+RZYWy7AwMoQqYBc0iSTd1L+65yasGRww0ym0dK9HPF3qS221VYeXDuVI2SCR
 hz6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783653233; x=1784258033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PYKRb++/yq4pz0JqrzTO+3wq3EfPyz5dZCeLpHTgzr0=;
 b=MWA5rJPBngqBk9mQ7NhZX9isFUcy2Rno6BTC59idAxrZYCWptM/tJKxlBLNIDJOPIu
 HD8+Kdwpxa0s9KvlpgdcsMRFR6PTSjYXOLjwlK6tD5h+gIM5vqTfOzSYNFDdoIva0Obc
 uZH5mnP6J4IUP++I9ApI4uMxcfEG2woYkbxq4mrWBQhXH2Cd1iLnLziD+k0zeYEbIWCN
 HNdTfNas/NNmINHvn7TdnkxlHIRi9Uf+1ZdEmchcufC1aJKvPA+xEYtlcrP0ykmBM2L6
 nE/yelw85ajBE05wMECDennjqGmS7Y7ZFAI2M77QpVSoMfB4nEzs3jNQgF3yBg045N1+
 80yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783653233; x=1784258033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PYKRb++/yq4pz0JqrzTO+3wq3EfPyz5dZCeLpHTgzr0=;
 b=N1FOucqgOjxEwYx+zX6mSviDtnDfLfjf4rh3iPAOxeJSjvaT0ZkQ8ppncQVp4V8yZe
 UxWwG1w2gr9FXJES20fWiMMmkNDAZsW8luTnhfyEmqMWOeiJR7QsTwzUp69tJUPeuYop
 hhm6Kzz5c9jwvyclqdhzQ+npvAb+d+t3e539KQdZjUmR4xvK7L4FIs2uB/Y+/q2SUVNB
 nuTDZ+d1yRFIlGHbxdAN8YSVt4AZxuJqgF+Ff/ilsjGmGEpOVP45DUgtadQXbzXf65PX
 wXWjLdZakbJszkVfo34O5ygpfIHTAW9usTfluPluSBGSgn+P7d4CbjfRp+U2rDdT9rJx
 3gJg==
X-Gm-Message-State: AOJu0YzgugHJD60yGgivqYumEtH2FlkPIQkuSmnM0HPJuBIR+75kLEsH
 EhmBYI7adx8GX7WzZLXygVJ4lsB0LEYLakGAFyufS66eAbBIWYZas3QWxljzgA6l5Sci96epeIY
 8KNNID5BCnvpUPOxUhg0piNaNFhS+GG0=
X-Gm-Gg: AfdE7clMdbul4lkCPYUmONFAPhhZohJzkc+e1D3qF8eCF+/c/XYFHIXVz35iKqnBQF7
 4csKruSOzESShpEKnqOyE62h59jyS3n7t2kEHFd6BOczxCCo7QvXu0jjlVIRF8f5D45u13rycS+
 5FF2fO7ZfSpTXbZa4ForP1W3gqGkVj9PGh491iHmSnCvekVt4D2/8Dqsy8UyNSdBc+2EV/GREYt
 iAI0nSn6QBkduPpajI5tQC4pWxgRcsrqI3eYNZioS3fGKb7qbGNdGvE+LviIrJJrXFxw2cL
X-Received: by 2002:a05:6402:3590:b0:698:c1ea:c1f7 with SMTP id
 4fb4d7f45d1cf-69ab44be646mr4106297a12.38.1783653232505; Thu, 09 Jul 2026
 20:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260709111315.1108185-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260709111315.1108185-1-marcandre.lureau@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 10 Jul 2026 11:13:15 +0800
X-Gm-Features: AUfX_mxaBgjaA7lwCl9Ya4l1JjfICE3P3tq7WpR_tv8ODrJ4ZSJic8VNAp5ruSU
Message-ID: <CAK3tnvJYtS5m5533_7V+=H5zHPXTfB26x_AP5YcLGGb=mOGP3w@mail.gmail.com>
Subject: Re: [PATCH] net/colo: fix g_hash_table_destroy assertion on
 uninitialized filter
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 9, 2026 at 7:13=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> colo_rewriter_cleanup() unconditionally destroys connection_track_table,
> but the table is only allocated in colo_rewriter_setup(). When the
> filter-rewriter object is finalized without having been set up (e.g.
> during qom-test property enumeration), the pointer is NULL and
> g_hash_table_destroy() fires an assertion.
>
> Use g_clear_pointer() to skip the destroy when the table was never
> initialized.
>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>

Looks good to me.
Are you working for filter-rewriter's qom-test?
There is no place in the current implementation where this issue would
be triggered.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> ---
>  net/filter-rewriter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index cdf85aa5eed..c85d180eb96 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -373,7 +373,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
>          g_free(s->incoming_queue);
>      }
>
> -    g_hash_table_destroy(s->connection_track_table);
> +    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
>  }
>
>  static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
> --
> 2.55.0
>

