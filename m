Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388D1112246
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 00:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w869r-0007gb-62; Wed, 01 Apr 2026 20:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w869e-0007f5-Sr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w869a-000218-P3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775090601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVhMjeycSQqWcXRBOvN7oSDs4tjuAhSenrXdfKlIaAU=;
 b=hCeKO3ORyJMlHpCMEOjnVOnA7C2q15jnCArz89aonx10AA7Cn6UUSR8z6g7CrtveQ5KIGd
 ymHOFGVYDpbls4Q6oA+bNApTKk4BYho9TX6MuYBU0v4jbQwHsKkm720PK0iOctbkv6LR8G
 0LgImuGx7bvhfsDNqu9p2ViYCXaBczg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-OaG5LhFCOaWaOmjts6dGQA-1; Wed, 01 Apr 2026 20:43:19 -0400
X-MC-Unique: OaG5LhFCOaWaOmjts6dGQA-1
X-Mimecast-MFC-AGG-ID: OaG5LhFCOaWaOmjts6dGQA_1775090598
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c76b6d4337bso136710a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 17:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090598; cv=none;
 d=google.com; s=arc-20240605;
 b=alYEXOr0pyRMvrhfFVzPdqewzOxbqB5o+/Rh+a8JnjjMmLhfXzy7s66d2L8DZ6CVtO
 OdHZur6E7yRXBrkAxssmru7NMe2DsgN/w+65vjv1ud/HNgFNDhpDZKNOvmfQELNbOiRR
 H5/CfCgisTKdVCn2K0IYhoZz+afu2We6N4wKlQRIQC55cuCmQyErRVcsyXPxlb2sTP8x
 5ANe8huyFM96r1Jo2AOnvG0Y1629icKUYtx6yXA/Qll1uYHV99vzkz4DWb+4EashvXbu
 hLdbacmEvlcPiCKD7+pfrNJvfoU6hVEDu1YR3Su1tmFiUtMyZP/hn32PZA/1r6b8xNeK
 4CzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zVhMjeycSQqWcXRBOvN7oSDs4tjuAhSenrXdfKlIaAU=;
 fh=fIAH26h2qciLIOlwUrSy+CVOzybLmcSdC91EXO3DGd0=;
 b=ROQixp3h/dIquVI9smc+W+zfHV1/825KDV8DiZYjNLmw7JYwySBTzAKOTq0sgSh2zJ
 f8UWvdGpZYiF5p7LX6wkLKUqhqkDSZB3lfWHt8241Z+O95g9JwDk6a+3s2JZdXWphbpo
 kOCEUpCtX1vp/6sRS79nLrbPplKWZiJnp/F9D7L2Wa62EkLLGNO2inFWT8PYYWNb8lEI
 fAPbyg1MDdHdbYpigeo3uP9CIjepGcKsCvCuXkHyhicY9U8it0EmS1nloOrVyqBTYQbZ
 ste8n2IhmRNWvE0LyHfBjJS6461DfVEsCD6dbSEISN9sen5wJJbFZtBdwHPQ0LF6KQU1
 MlfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775090598; x=1775695398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVhMjeycSQqWcXRBOvN7oSDs4tjuAhSenrXdfKlIaAU=;
 b=p7vRiv6EtT1DjXG3g3QeYVvrp0V/x5uGzLJvCs2NTJvUhuMCbCbuwXgDZnfwNbz1C1
 l9Agokvsx1RMmLbpqey0ifnuGig4INLulRn8JWZvYMke8Y8ukiCKX+85IwZy1XyUScyA
 lf/PirJn6U+Fc0anPb2P/ZBK3wPaT1tPnGYHHiiwRp4VEKm6Trm37drPA3aoepTECbza
 DyZ9QV9uGCpHcmc91pDAFdCNjPSJt+W/9dx5rrrHcaaignB+5Lsq3QmI5BQP95jmQDcn
 v2kEFy8wJ5/WCyL+FCRS6ebiF3H8NFypHySAIgawH4AGFZXnNxOEt7ukRNhYL6GwU/0Z
 RRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775090598; x=1775695398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVhMjeycSQqWcXRBOvN7oSDs4tjuAhSenrXdfKlIaAU=;
 b=QnZWTYP5vPSKb8XeK9rSNjVOgJMuLI34/k6FgMGFauYUnidEJ3dOyVXrIWoYvv0P6O
 ulu6rScqBcqP295UMmbiinlhhZBxWL+O7fL/RaiB6nC4WnpxtNxKQRWociSZUAFuFaMT
 bauReFaW4qnXjQJYxhWWReOioM/iWHH9mE4DEI4rWiMYsq94YZayuR+dJva88Rmk3PgP
 0QX+jjwDC0Yh/oL3pr+1zrdx0ES/x1E0BeWgo/xh35HCj1R5rvLFln50Mk4ROileGx4/
 ZePLBLgjpK0/8XsY0pAGaCnzM2os6CW3hP5aasgZXQQHVcVZrODslL4W6Se70UKD7E6O
 6f/Q==
X-Gm-Message-State: AOJu0YzQ2ZP2wxgRUcdF/ucErjH1BnObwvCQohzvlB6U3srq8sh2tgYF
 9ws5OtUV7EhiPfqsny8G0HU6q1QAxjNUlcRljpp1sLeFlN8LYKRkbPKO+pTkru3cq65nnA1G/0f
 c+mQ53L41uhGSrumSMfSFlviXCZs8PLOKH6zihpFsmeBbFKcEP2p/SybMjkMgmq9VIfKz0EpVrz
 UKm8P/IZ+IbOu5Preq2K3V1x/niSUrWRvS/NqT0ok=
X-Gm-Gg: ATEYQzxjzrwJgPoCunEYpey8WG5BXB17SxK7niqMcoXZy6n3R73fH7cim4WWKDU/AqH
 2/J9seiHuDv3MwOx9XLry8XG02NeiJdTUiwTSWADS6OkiWcoEKAvMXSrAfFCYzKvZyndHFb1Ivb
 EojkAd8/xPSjO1htOEMS2coac2dd7lPibrdXUI5utkTFg7/lVAf1eBx6HVn7X/8npah704cywP+
 +w=
X-Received: by 2002:a05:6300:218b:b0:39b:989e:6d39 with SMTP id
 adf61e73a8af0-39ef76c1b39mr5878496637.35.1775090597577; 
 Wed, 01 Apr 2026 17:43:17 -0700 (PDT)
X-Received: by 2002:a05:6300:218b:b0:39b:989e:6d39 with SMTP id
 adf61e73a8af0-39ef76c1b39mr5878457637.35.1775090596870; Wed, 01 Apr 2026
 17:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260401082754.96320-1-xieyi@kylinos.cn>
In-Reply-To: <20260401082754.96320-1-xieyi@kylinos.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Apr 2026 08:43:04 +0800
X-Gm-Features: AQROBzB3qyRpawpaDru8DbQtGlF7D_dRYkkkQu_2TjWFtOYsLZko_LwlzAjBQCc
Message-ID: <CACGkMEt+K8z4PRiz2APTnvHuQap-nc40jZR7USCPudt0K_n-yQ@mail.gmail.com>
Subject: Re: [PATCH] net/filter-buffer: use qemu_del_net_queue() in cleanup
To: Yi Xie <xieyi@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Hello,

On Wed, Apr 1, 2026 at 4:29=E2=80=AFPM Yi Xie <xieyi@kylinos.cn> wrote:
>
> Signed-off-by: Yi Xie <xieyi@kylinos.cn>
> ---

Let's have a change log here.

>  net/filter-buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index 427da24097..ce3e9027a0 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -95,7 +95,8 @@ static void filter_buffer_cleanup(NetFilterState *nf)
>      /* flush packets */
>      if (s->incoming_queue) {
>          filter_buffer_flush(nf);
> -        g_free(s->incoming_queue);
> +        qemu_del_net_queue(s->incoming_queue);
> +        s->incoming_queue =3D NULL;
>      }
>  }
>
> --
> 2.25.1
>
>

Thanks


