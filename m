Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD9E98DF5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 07:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQRK-00053A-R7; Mon, 23 Feb 2026 02:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuQRG-00052f-BB
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuQRE-0007ei-UC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771831984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcGQz5UrdYbm+4/7S3bJAI8yW/MEbu30Z9EG8f7JjTM=;
 b=Xa9KoN2uRt7xEiBWcleREyLLswrh9wXcZbozjTbCNmfQLnAf03AOj/pVEYAJBQaGhhcpJ/
 c0/zIWSHio5IODYd0sxQUquMJ4n9RtNs09N1YsFFzRCs1KCWmLxR2t6qFUvGbSZdPSeO4M
 YLr41pCm3cQufXIKS/x2Txk1qY6Ejuk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-tgKrpQalP-S8fxkXoa9ykg-1; Mon, 23 Feb 2026 02:33:02 -0500
X-MC-Unique: tgKrpQalP-S8fxkXoa9ykg-1
X-Mimecast-MFC-AGG-ID: tgKrpQalP-S8fxkXoa9ykg_1771831981
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso31034005e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 23:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771831981; x=1772436781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcGQz5UrdYbm+4/7S3bJAI8yW/MEbu30Z9EG8f7JjTM=;
 b=Kshg1gfHsu8pgrZdWx/vnTiprwvXTC2J+dawGgzjyvM9BYaEXaXd+Jl6Sp34HlBa7J
 qHwtQ4DgCQpJn1iDJ/D0YhG5wM/CzrqQA6rBHkbQHJE1e7+M+ekOGEzf3dysRjbwWri7
 +UrQLmf0iclGVUz8StKTme8oV6SmjucenSGHrYelYa0fQHiI2XPyeH+El5K3OWpvsGjk
 J4VI5yMr8YT6b/lfXLtVTl7SXWI6iDDJ6cTdaZy6Dj3MeQ6BdiJF/Ulmzou7QJvsC9lj
 AVqTDJUPvy33JWR5yX5ll6kOkaGmLgJSL5Zpw7dXalSg86gMOcI23Zcspzc6prZnA8/w
 KPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771831981; x=1772436781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcGQz5UrdYbm+4/7S3bJAI8yW/MEbu30Z9EG8f7JjTM=;
 b=JKyeOgQ38V3es/5hxkeHea3KitaujduJv+iLWVuIj9K19lqGKcmJgMyMOvwNvi3iyy
 7XZk1G4yS/S7FOdV44lus9+GE7giwGHEePCZ6TT+l+ZntsneBwA4poiude/oEqy2i0NY
 D79kSSpNsPc1farBK38ZJQze3T15YgPhzj1OPfYjZzoSvZ9S4vK8KOcQCqpRj9VEGHQO
 pKdoUuzsw7O6xgbcNqMlfTK4CdRU69KMPKnRz0nyP9imCxWaEbKZzTP5ReKh2HT5lI0m
 Ozt+v9O7Soi5gX5iAcrWCFHZIvQeczazKmpVd8c1sFm+TLIJ/jbNQx8pYtwok93bkaYd
 pKcA==
X-Gm-Message-State: AOJu0Yz+pL6gdMjJMAkbXCNRgCdK8G175nDlQF9KdbW31L4e37JDhtPW
 +nLJ35lyWtFicLCVojsYxlD6gme0TDm3F7tbYXxPTVCsjj5aeHAiS8YFPXXIcdoIbDKF9t2zilr
 58wWPWmICP70Jq3W34T9iplXVxGaUxRaCTxd1UNKVX9bOEygc73mqACt0
X-Gm-Gg: AZuq6aK4acI9z4xZyPMmLfzS1LJKdok8BLdeLPf99B76tKFLbC2gaPIiq74o0/JtC4i
 7ru7Vz0z3ww5YLhrKWBUuTpPv9amU1KTTUQHnyygb5O2IFPzzI83pk6a9HCD4l1Srs+fuxUB9AN
 m7CWBnzv93NE4z6J1DaBaeQ8hOvhK1TGQ9NbUNuCNO55EoT4VmRlO/KDyj7w8tgL/daMDqjeN2k
 dnihKhxkaMN1tR9N+HaYgsxzXDihYbn7gXMnfkftjfzVHgWlg/qzGtWwrhl27Z5U/RLvL70dgCA
 jwy3FWzfcFnqD1b8LcPvkMPzM9vFj7tJ7XlDtmUMr4zSlCLZa/EwHUblcgzZ8YWtlxrUGGgSTzO
 5pQoaiQ==
X-Received: by 2002:a05:600c:5394:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-483a95b7180mr131929755e9.9.1771831980858; 
 Sun, 22 Feb 2026 23:33:00 -0800 (PST)
X-Received: by 2002:a05:600c:5394:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-483a95b7180mr131929345e9.9.1771831980376; 
 Sun, 22 Feb 2026 23:33:00 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a430927dsm103236585e9.31.2026.02.22.23.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 23:32:59 -0800 (PST)
Date: Mon, 23 Feb 2026 08:32:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Hoppenbrouwers <qemu@demindiro.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command
 logging cmd ID
Message-ID: <20260223083257.423660c4@imammedo>
In-Reply-To: <20260220181437.19338-1-qemu@demindiro.com>
References: <20260220181437.19338-1-qemu@demindiro.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 20 Feb 2026 19:14:37 +0100
David Hoppenbrouwers <qemu@demindiro.com> wrote:

> The command ID is in cmd[0], not cmd[1].
pls add a reference to the spec,
and if any what impact it does have on a guest/how it manifests.

> Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
> ---
>  hw/i386/amd_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2..2570a4701c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1456,9 +1456,9 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
>          amdvi_inval_all(s, cmd);
>          break;
>      default:
> -        trace_amdvi_unhandled_command(extract64(cmd[1], 60, 4));
> +        trace_amdvi_unhandled_command(extract64(cmd[0], 60, 4));
>          /* log illegal command */
> -        amdvi_log_illegalcom_error(s, extract64(cmd[1], 60, 4),
> +        amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>      }
>  }


