Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60917D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT30P-0003dl-Fn; Tue, 09 Dec 2025 14:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT30M-0003dU-JG
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT30K-0004h6-OV
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765307041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOrX4uL+eGBTHZAlSDaFSqaCxK70jPEUj6inO1aBNTA=;
 b=ZV392pdIt+7ugPKN9gNChAendomcBmSseCwlpBqAc3Pp2p4dQPQVQzWqO0WXUilOE/8Zdv
 QUe6/aJFGoTNtdsSkScP+yZIRhU8SUuYEJKgXlT8E5llvuuT0TwY4+QDTv9Oj1CN2fnuQ1
 2dAd6TuT40i/k+or3L7i5t383SDTg3E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-RHF8iyKeNn6-7ZfzxcnjiA-1; Tue, 09 Dec 2025 14:03:59 -0500
X-MC-Unique: RHF8iyKeNn6-7ZfzxcnjiA-1
X-Mimecast-MFC-AGG-ID: RHF8iyKeNn6-7ZfzxcnjiA_1765307039
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ee3296e984so109934551cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765307039; x=1765911839; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xOrX4uL+eGBTHZAlSDaFSqaCxK70jPEUj6inO1aBNTA=;
 b=FROSGa3oPNNgtZJT0VaAA1ZNXIS7hOTDUt9D9AxASqv8/PdUxT+pQ73aXxXOxtKOjI
 ani4XtfN+uOzfHG1E1M2yXC559s9r6DJ6U1nLOfOhK1J8yzL9AKIbQPQftmJSfwdxPd+
 yhopHmQ9ua32E2mj2xU/eB7yS9zk6I2hqxt9lfACzGyv5QWZxehgqvuoK7Jaj3hhB/bs
 lwPCGYHdmKuczUCKws2694TcmzWuVGRin42SLcJAKWlZeleVhtml5QHfQLJvtjHUTtXr
 1tSA0ullMCpxbggbpa1riwZ41BlESQX2gKTz7yWBDh6uLdZo5zdCLmLBfOWeRQDEjQNH
 CDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765307039; x=1765911839;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOrX4uL+eGBTHZAlSDaFSqaCxK70jPEUj6inO1aBNTA=;
 b=X3WY9GCC8MpnVgwKkLOBL0HoJp3D97ujLPNCIcu7u98m05SA8NPdulTuOmjGK7hZM9
 H8NOkNtuvhG1zAF3+aqNniT7cxN6/U3siHZu14vk6AIFVmnIAMvT3ARKKwUmPZWcjRTP
 qN417Qmlm1KUoJLWDBN/LxVzrbziGr9iTpEfaEbhItQIXYeirboEasZC0KzcyCmGkoM7
 AQhrfM3sDcV6sQ+jWFFy9+9wSoBRagDDyGkx/cuuxeI9i7OaVbUf7O0uqmla0hPoWuHc
 qovMMVAABorvQNpQrSxYC+rpU+rTQTp9+VLwFajG21qhNgBpKODlfUna/U9L5dIcD71R
 sJJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmqkwPqPpo888setTzVbQ9Ht+kRlDWP34105VJvxRQxkHN5l8T+yQfVhbS0KRW0O1MwpC9WWzlmwp1@nongnu.org
X-Gm-Message-State: AOJu0Yy7Gqk6HopHaEyxbRtaxbQo7eKswMJZ+fGbXzWzj1GYER+CuZxv
 /V+PZLvOlnQNCN2cidrj+/l/Rbr4Wpt4SVu5acWPFrol0HIMij2HHI3lt0QundFylJPowr+IBKe
 M3W3tEHR+JztM6vN+dA/EwjkizMvxTaEKKc/R+mYBI0fhSZv0KvcJ1/qV
X-Gm-Gg: ASbGncv4n2+EGkhKmPULbLs1SAFFYmYcvoehpelObd5ZBbkeqhkTStjKZHobRpJk02/
 zuAZ/qEmoHdpS1PIl0/oAOGvvBLK7jhpo0g99WbgzuKNayf/lKr58Ac2JYowiGLJPSz0mkIkm8o
 NCIVVJgUrRWttvijYMt8R9sMiU3wgRhLy1sKKojU8vYskCJBf2eTJ3DxPoZE6pmy2JxlfQAiFIk
 PhDkeXjex5fIuASr7Qea0Yq5CE8u5U04toulGGKBwViUEQrfInnkz8bseJzlOsuKAdgWCaZSyYr
 vQTSRwnbzKftPhJ6Y+qB1TSZnNt3zR8FqzEwQMcTp/W5SwM2UGNh25WS6ThnZwncNVRTeQ4rmA5
 SXZk=
X-Received: by 2002:a05:622a:164d:b0:4ee:1d76:7341 with SMTP id
 d75a77b69052e-4f03fc83d56mr175194331cf.0.1765307038708; 
 Tue, 09 Dec 2025 11:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOOmWl52iI+s6TTGdqpdPNWWNGEcmAa845KK+fvqfcuBfIdDluwtK1pmzmWryy31zYVI0DHQ==
X-Received: by 2002:a05:622a:164d:b0:4ee:1d76:7341 with SMTP id
 d75a77b69052e-4f03fc83d56mr175193881cf.0.1765307038279; 
 Tue, 09 Dec 2025 11:03:58 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f0276b060asm104130481cf.10.2025.12.09.11.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 11:03:57 -0800 (PST)
Date: Tue, 9 Dec 2025 14:03:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH-for-10.2] Fix order of function arguments
Message-ID: <aThynO5EgO_YF7Pz@x1.local>
References: <20251209125049.764095-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251209125049.764095-1-sw@weilnetz.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 09, 2025 at 01:50:49PM +0100, Stefan Weil via wrote:
> This fixes a compiler error when higher warning levels are enabled:
> 
> ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
> ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>  1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>       |                                                  ^~~~~~~~~~~~~~~
> ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
> 
> Avoid also a related int/unsigned mismatch by fixing the type of
> two local variables.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  migration/postcopy-ram.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3f98dcb6fd..8bef0192aa 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1467,7 +1467,8 @@ retry:
>  static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>  {
>      PostcopyTmpPage *tmp_page;
> -    int err, i, channels;
> +    int err;
> +    unsigned i, channels;
>      void *temp_page;
>  
>      if (migrate_postcopy_preempt()) {
> @@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>      }
>  
>      channels = mis->postcopy_channels;
> -    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
> +    mis->postcopy_tmp_pages = g_malloc0_n(channels, sizeof(PostcopyTmpPage));
>  
>      for (i = 0; i < channels; i++) {
>          tmp_page = &mis->postcopy_tmp_pages[i];
> -- 
> 2.47.3
> 

Thanks for the patch, I'll wait for v2 per others' comments (or if Laurent
would pick it up).

Please also consider adding a prefix ("migration:") the subject.

-- 
Peter Xu


