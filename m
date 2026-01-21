Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDCC4450D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXCZ-00081S-Lw; Wed, 21 Jan 2026 07:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viXCX-0007xo-Cb
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viXCV-00007r-OO
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768998041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nv0KE+tMna4Okj7qZ58dJTMiO8MDEoTi17Z4BPZzp0A=;
 b=B8xCMCGJ/JsWpjydeqH5vWE93BTk7YGGunpXYCUyXEcy+C0RSEw0IukWpv54Nc1c2Pb6h8
 qwQm4N8mQ012s3rrLXRssL1RsB073BXWSgzHg3FjReeK72bVGCYTgvT+OKXHf1EqCLZAs3
 FOwGHj6htloJClCUc2ejqc5K9Vrw1nE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-5tH-gvQ_OP-YmfHvabOaYA-1; Wed, 21 Jan 2026 07:20:40 -0500
X-MC-Unique: 5tH-gvQ_OP-YmfHvabOaYA-1
X-Mimecast-MFC-AGG-ID: 5tH-gvQ_OP-YmfHvabOaYA_1768998039
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so60387985e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:20:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768998039; cv=none;
 d=google.com; s=arc-20240605;
 b=jwbwa2pp1D89KYhGp+fMPsf/prEsqkSViWNzEl+7+/HiTtURaDJ12T/7kwdqqY/HjK
 vxPHr9SIO0Fe5c6iA3nvJDR9fq6cinDAEMdiNVkCClUs9m843tpZTmMbNIdayO1FcUoQ
 g12MHqxA05Ds5czIJR23VvNrcjutI8MTBpstSLFUks/jazlDwk9E2Ye3EHmZV7YkuMz4
 86nO/nX7bSN83KEM0+aq88/Ck9VHWFyTkviPJci6VN0Bp/wePvkFhBsYlcq39dGbepoz
 gt6OPSv82oW+s1rBcVXFSB/TMfFaWPZDYy0V1ven9RIAmXIeNLgFmQeKWJlNHNV9+mNs
 NC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nv0KE+tMna4Okj7qZ58dJTMiO8MDEoTi17Z4BPZzp0A=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=IMibuxz1vYyKqgQTLz3IAmYIF6NWXgz9M7XGZKMcedEJe83tlgOpGaZi8jwq9KZ5tI
 6WgtNtfRBJOnOAY+J3ntg6tUxsfpEKW2ccgpst1PrSX5BJkbxdXN3ctTjHJrGC0sRptv
 xzR1pBM1oFX32ZjgsLfza9GJx3ljiu4+x2PP6YEouA1B0pC0zt/tf4EUwBMSnbVQU+kz
 3b1Db/SOzthEzxKMCOT8qUhAqEvUihGPduFWeZ+jguX7mCCjtPGQV7RLQpzAcJu2WIDG
 Uki8ngl9ENhUOm8Y+i3njMUvM5vVPjbnWwfqg2STJ8V0BsP6T33Wl7SPb541iVFnfvK5
 X6Xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768998039; x=1769602839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nv0KE+tMna4Okj7qZ58dJTMiO8MDEoTi17Z4BPZzp0A=;
 b=pCF0SQGRv4bVcIgr23Lo806483dI4ZJ0JZshhqScCI9aBQezQb2eSEy7z73rwnVsv5
 jH95jjyKGxlADUlfgWe0JVZkzP+1f/+x1zchFxVlonOwmzj7Bkwe+dR1Ofx4tQ6C+TTw
 jCKMhBCb4GFrjtxJCniHTd03AjVFe6V0lC8+QScTS22Ro3WFD68WwYAp8ZsgAkhDAXMc
 LAkjskrLaLdzP87+H2rJaygSAirpM+I9mkbJJKF+O9aP2sdf10Ay+o3pxlRV28A9n9YZ
 2Lo3w6uYGFwVy9bh4b9M3zEQoP3dRi77kucPY2ITVub3xrLdzYDIqAqyRl6cGhsRRHUH
 aXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768998039; x=1769602839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv0KE+tMna4Okj7qZ58dJTMiO8MDEoTi17Z4BPZzp0A=;
 b=GtsOEZkX+1UQ1QRGkpXiuAEvKgeKWnAtCgC5rTzmQxLax4veUYRPFt18uXoNnPou6x
 cNvrLqF9NgHOoykE2IrbCIfjtI6N+ocWJAQqoTQqvbC75tUG1lPuLDsAokMCfFC9Qrgv
 S69J3ixbBK4Y88FJ66FPzLo96850A0J5wyDVSB0UoiYEhzEab5ck8MNnewSk1xXXWSaq
 +zccaRM6dnRYNPh5Pm+jbEVA7tHwoCT4tNH7yFqycpSgXS7vqrVnDzosVGiwsAYlNjmD
 98AqyxrCfZNZMg31o+nudH1aKcxuesR19gJ9vGnl0AjYWOUe3lX5CblTxni9jjde6o02
 Ne2Q==
X-Gm-Message-State: AOJu0Yyv9zQmPTCofcYzM/BM/5mnFj3xtclW8giSSFaZDRLhJ8DSRO/+
 yHJcjpTDpH02RKpMNlTlD9I7I5P2hieosfXNO+SJ3j72GinVuNoC/X8Pm1LlSD0OYE79/cq2gWV
 OKu+Ie8LsUU3GvAv0TSSp2gXIv9LreqYlY2ggU0AoUCnSkdI1y3ulQ483QIQCPryrljWwxUrT32
 oH+20TIFhYFDpoqlwTYgfsKFh+2+502N0=
X-Gm-Gg: AZuq6aK8bzY5pMt/iBfiTRUs5jT6vkuQE3qxJRw8dipkgtvek5U2BRVPGiHzrLx/3W1
 NUxhtda33PhcO08Hij0PU9KfoCd8AKVwARwJb9SZRQibChxh9D9rFlkLwpdgJRz3BRDxob68gGH
 a6XaooUQ4I73PjkFnF7Kpd2UYcXwyvXeScREUvMImRoeaD+P0JerUFm/tkHDXASVbGuMxwlEkBM
 Jc47yqjNcH214ny4uLd2JbnsDMWk3ruPCJuJqzSgCID2E9QWkcp3uOI
X-Received: by 2002:a05:600c:3e8f:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4803e7e856dmr84981325e9.17.1768998038887; 
 Wed, 21 Jan 2026 04:20:38 -0800 (PST)
X-Received: by 2002:a05:600c:3e8f:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4803e7e856dmr84980945e9.17.1768998038516; Wed, 21 Jan 2026
 04:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
In-Reply-To: <20260114132309.5832-3-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 21 Jan 2026 17:50:21 +0530
X-Gm-Features: AZwV_QiAG0hjXsqpzVSKgyzasvg9Zcr_SlB8xhiLDQpwVEcsXlAxXt6nJw8gAGQ
Message-ID: <CAE8KmOwKaETNiiin6JATUFzRt=DxtaXVaoTw3EgvGe-N+6qWhw@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>              migrate_get_current()->has_block_bitmap_mapping = true;
>          }
>
> -        migrate_params_apply(params);
> +        migrate_params_apply(&tmp);

* This change looks unrelated to the rest of this patch. I see it is
done in another [PATCH 5/5] ... QAPI_MERGE patch, we should move this
there.

Thank you.
---
  - Prasad


