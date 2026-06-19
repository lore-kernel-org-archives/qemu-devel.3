Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F378CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waUZq-0003e5-3z; Fri, 19 Jun 2026 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waUZo-0003dx-Pb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waUZn-0000uh-A0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781857666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0efTbBVYjrCSLl/Qy5OGO3/c50uaYeo+0DEw4k1gF9M=;
 b=BoL8VYFx8g3eTm0wvGlYD2T0g3G7klKS1EEVxvy4Tz2H3/5503XR3jP3gOYdPop5lY1SUv
 nhoQ36XH+n+0TFGJmPL2Tn5/PntlL+g/mw6zXnr0s77dWuqy7bzgdIb+yoEqLa8onU6qch
 nRrjdkhyyFCpt3ErhkjHZYiR5siP1MY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Xr4qTZ17OtGawO8Pc4IZUA-1; Fri, 19 Jun 2026 04:27:44 -0400
X-MC-Unique: Xr4qTZ17OtGawO8Pc4IZUA-1
X-Mimecast-MFC-AGG-ID: Xr4qTZ17OtGawO8Pc4IZUA_1781857663
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-463dd955dafso1134153f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781857663; x=1782462463; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0efTbBVYjrCSLl/Qy5OGO3/c50uaYeo+0DEw4k1gF9M=;
 b=U/VK0neSMyxrgBtCkbbR5VIWE5i/F7CZQWHLlsNXKL2NcFld0M6+rDnqN62L848Aj6
 +kn2oVPfjiGQNXeL+w4Fz5OTskIEqQU4c6ykLHLznm3NXAJ75PS4ti29qkw1YinKIVnq
 tMq9TqGyMUgiJH0Bwis7Afeh/5va/s4AQXiqLs4clCqo/5FehxDepGyLSzvd3nZWBoj+
 k+dhT0fVCM7pmx5o2/IupUamycZqhCzccupzfSwChKn2CCTQvOtItug2EXxoblxFm8UJ
 lk86q9nhTKeEnBPfL/zc2L37nP8teg38Ylm8mf/0jlpg5KafllfXig1pazf5phniaPAh
 zxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781857663; x=1782462463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0efTbBVYjrCSLl/Qy5OGO3/c50uaYeo+0DEw4k1gF9M=;
 b=cXk5E2a9kjB+N8YgWk64mHpOAbtH00J4eVOpsQfs4pwcLjFLWFV6efo/kljxYPSFE4
 H1yZ+OT1zClwTGf5zBcOS82gXOehG9xipQE9IwihT3wZc0AcBLGA2UhFtEUEg+c3fv8I
 PeFOhcfX7uzlhNP8cWoow5JxVhfAyrWss7hlRn8TtSDF4lGkizaEtPCltF3XE96Pcuf8
 i5kT0e51p7oRjRVnkShAc4E8Jjfx6qwk+SgJP7gheOtfW7A5d6Us5nXGRJuN2jxbPekF
 Lut5wk49xpWjrQ4O6eEx195lOxFmUkg0QZXuL5hKHJPAc/4lKKyNJchW79QnOBkA/gcS
 AADQ==
X-Gm-Message-State: AOJu0YwhR3FeXObqlqDcRKuhD/vIM3vvMuUqgnLH/4yq0tWeqr7DFYAo
 g7zo4OLcLs4FcXhdBJlEEYUGrm/UgPaxZ5yKxZ+KrSfFFYFLykdqIwWOMxT3WPkeJru5MJ5r5Bm
 pCcuLk3YL1uhDppxcRaVC8JzD8vQNs+4qaJ3y2MjMlvvWqtCajLFRfvy/
X-Gm-Gg: AfdE7cm7QbtwGpLwoeBape8uaAyq7ypf7vAdxpiK+ACzLuJKChVIk41LDKn62mMBn1W
 uHmTvbZISwlNozfsGh9YQH07+qYKnmvY4PJma7CnWc45L0ZY26siz7RoShEgBntAjiNJdQ1ewso
 hTV1B1xCfrC6ovq3A2JkEsVeBKQX/fUOQSY94198LqXUixBojm+CHfEk8A+gUna9cogFRn1GXZx
 +1VZmWGs7/rXT5JQWtNbGVXgmAqtkGzgu6g/U5TfAqvvDUmKgdVSrzi0tHpP0wMRNBE395th3yA
 gKQDc7n4elV0VyD6g6LaFcZFenPvT1pZVkVYaHqIKiqWOYPZjoga38hXlHE4bGMChZl16S78GWu
 wJNEEIJPwFdf4tT5f5rfShpRKLImfM6Vx
X-Received: by 2002:a05:6000:2006:b0:460:1e5a:2267 with SMTP id
 ffacd0b85a97d-4650090b736mr4632731f8f.17.1781857663226; 
 Fri, 19 Jun 2026 01:27:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2006:b0:460:1e5a:2267 with SMTP id
 ffacd0b85a97d-4650090b736mr4632700f8f.17.1781857662699; 
 Fri, 19 Jun 2026 01:27:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46508a04692sm6609664f8f.6.2026.06.19.01.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 01:27:42 -0700 (PDT)
Date: Fri, 19 Jun 2026 04:27:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [qemu-web PATCH] security: rework guideline about issue URL /
 CVE references
Message-ID: <20260619042659-mutt-send-email-mst@kernel.org>
References: <20260619082236.1175764-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260619082236.1175764-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 09:22:36AM +0100, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Thanks! something small to improve:

> This incorporates the feedback that Michael provided on the
> just merged security process changes.
> 
>  contribute/security-process.md | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> index c091fa1..146e9cd 100644
> --- a/contribute/security-process.md
> +++ b/contribute/security-process.md
> @@ -92,19 +92,28 @@ be scrubbed before disclosure.
>  
>   * The maintainer(s) will develop and/or review patch(es)
>     for the issue privately, optionally attaching work in
> -   progress fixes to the GitLab issues. All patches must
> -   include the issue URL in the commit message(s). The
> -   **"Workflow::In Progress"** label should be assigned when
> +   progress fixes to the GitLab issues. The
> +   **"Workflow::In Progress"** label can be assigned when
>     a maintainer starts working on a fix.
>  
>   * When a CVE is allocated, it must be recorded as a comment on
>     the GitLab issue, and the **"CVE::Required"** label replaced by
>     the **"CVE::Assigned"** label.
>  
> - * The maintainer(s) will update the commit message(s) to include
> -   the assigned CVE and issue URL. If multiple commits are required
> -   to fix an issue the CVE must be included in the final commit in
> -   the series, and may optionally be included in all prior commits.
> + * The maintainer(s) will update the commit message(s) before
> +   sending a pull request to include the assigned CVE and issue
> +   URL in the following format:
> +
> +     ```
> +     Fixes: CVE-1980-12345
> +     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/75
> +     Reviewed-by: Not Me <notme@elsewhere.com>
> +     Signed-off-by: Some One <someone@somewhere.com>
> +     ```
> +
> +   If multiple commits are required to fix an issue the CVE must
> +   be included in the final commit in the series, and may optionally
> +   be included in all prior commits.

And the Fixes tag? Same rule?

Thanks!

>   * When the maintainer(s) are satisfied that the patch(es) are
>     suitable to propose for merge, they must be submitted to
> -- 
> 2.54.0


