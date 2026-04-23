Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C2DF589D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuNw-0007vX-IP; Thu, 23 Apr 2026 09:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wFuNc-0007uX-U8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wFuNa-0002Yg-7l
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776951962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umWSGhwXjp13GgWmuga0aMUcGzPUo1FJVUkucVpdH04=;
 b=gAOw4/3WZmFIQdoYuqBryRo2oghC90Kqqv4UwHAmHT1jR1E4cpm60KUiIJ3R4HQd+5sR5S
 GMGF30KTb4YR8UsUBn1TWlrwkl+Dm5o2sp94/1acNqfJ9rs+29wTCTnoxDMbx9np2h87hw
 z7hcsge2naBVqCvnYHetn9esHischsQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-z_AiVprlO02dm71au6cApQ-1; Thu, 23 Apr 2026 09:46:01 -0400
X-MC-Unique: z_AiVprlO02dm71au6cApQ-1
X-Mimecast-MFC-AGG-ID: z_AiVprlO02dm71au6cApQ_1776951960
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3595485abbbso8296297a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776951960; x=1777556760; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=umWSGhwXjp13GgWmuga0aMUcGzPUo1FJVUkucVpdH04=;
 b=gY00F838UWmJWFgJwW3Ffhhy9IZ6AecGFhveU87VBSdaH0M1gssAGsEEuhxmtAceQi
 Awyr2r1MMWJ+yxOm1K3+H8WF0vIY1+tsTc/zyqUWkV8YozSgk+bsEj5ovPgXZHf9+LKe
 1WEVbdaYTU3Bx9a1UBKXixZdUvg+s3GMu869kDLA3VZNz1ZsZknYRiMnOWvki+KnGpxX
 Skf3ZjEEY6S+eulqzyiX+xuq2x+UnBTeXhNK1a0YnPs/kPaau/NOctjZ2i11ySjLhHiC
 GKpjQ40p/0719ajbNsfY9wlhwfPXOvxpYdRw54ijunkv2bChCKSwyg2F5LCAdqDUypZQ
 uf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951960; x=1777556760;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umWSGhwXjp13GgWmuga0aMUcGzPUo1FJVUkucVpdH04=;
 b=LkYvErZrF2Tp7cNFKcs52Opk/cIA7mcgh/10TevAF8itdXPLBZ3fb3GJVrLh1fqKzD
 wyDE6S/USVarUOR3RMtZpQgxn88Kn6H4KBwytlNaCt9IAlUtKARdirhwjojcsTVAHAn9
 1uy6XUj8yuhpbxj8DHDUyx9nN/PnFeGU72PmLWDfrEhX9FctIM1Pce2vApkWn6ZRIVwA
 zT/sbYuQCI9edYbdw5q6sYZYS+aUuCASfweRooX94BAv4vrMYJD0xTl8JwwytMs60IBQ
 CxqXxwhMfb8YYwAiWnSWDdj5QZwO3nApoQUGQCi1RZPFt+7/SXSZyUN7nd4CaWyAjEcT
 KIhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PBg4tUe9K6d6WC7Ui+EOJXX98jUHkTGEfomYwOQwNp363eqk66PcAqSUQsqZoEmL85er1GGN+YBRd@nongnu.org
X-Gm-Message-State: AOJu0Yyt+qGN6rHK7j7K6nr2v1ZjgGAJn1iQf0gbu69SK8XjQ3481X/i
 lyBH43i1Ffhqqet6E77+F5Kgw2yL7mfCHXGG0c6474Oca5mVGDpCMCoIinvpWaNbJWlkMcF6E86
 JedmxvsS5Wz0D7Brs768qYByfP3ULIKTjmU971Nuh298pQuTahaDoY8O9
X-Gm-Gg: AeBDievz6yCC615E0wldDf6UrpAanDzRKyelNjs+UY5UwR6n6yS1/Max/DRFfFe3vqs
 84AbbOdXGfubC3lNaCqgdF2cW0eHdKmvQhKuxt1zWyaIpHjBn7stDRCjV7VcVaN6+7fpxDRB4a0
 HO2wDknthsdNOn4CdqO910EdUwSj3mbVP4o/SQop2weYF6ZRr0whiTvlbVOQTnkSQH9BgryiELN
 3xgBTRp6g4Oc0yBAd7h0bafi14kno0ESpiKeDc9mw8hoYKCUTqDendxGFNFUdCUVP1Edjovylp/
 MkXV/nwIVnnhDK8+4CpFFwptdzcl52ULOp61Yf94VzkA+8Q3WNNLHvLDBfJfdMjFMQjU3AIqq2z
 f0KEvk7rvSE/lGjWewRDFfTxEu6wosw==
X-Received: by 2002:a17:90b:4fcc:b0:35d:8fdb:4f26 with SMTP id
 98e67ed59e1d1-361403b7d66mr28635663a91.1.1776951959972; 
 Thu, 23 Apr 2026 06:45:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcc:b0:35d:8fdb:4f26 with SMTP id
 98e67ed59e1d1-361403b7d66mr28635616a91.1.1776951959410; 
 Thu, 23 Apr 2026 06:45:59 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7cb5sm20382034a91.9.2026.04.23.06.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:45:58 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:45:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 25/32] crypto: fix lifecycle handling of gnutls
 credentials objects
Message-ID: <aeoijCiAfbgGewXE@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
 <20251103133727.423041-26-berrange@redhat.com>
 <9163e2f3-4bb9-4010-964f-20ca66ba964f@maciej.szmigiero.name>
 <6ffa975c-9d13-4569-bd50-59df75c89b9c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ffa975c-9d13-4569-bd50-59df75c89b9c@maciej.szmigiero.name>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 17, 2026 at 03:31:02PM +0200, Maciej S. Szmigiero wrote:
> On 3.04.2026 20:25, Maciej S. Szmigiero wrote:
> > On 3.11.2025 14:37, Daniel P. Berrangé wrote:
> > > As described in the previous commit, the gnutls credentials need to
> > > be kept alive for as long as the gnutls session object exists. Convert
> > > the QCryptoTLSCreds objects to use QCryptoTLSCredsBox and holding the
> > > gnutls credential objects. When loading the credentials into a gnutls
> > > session, store a reference to the box into the QCryptoTLSSession object.
> > > 
> > > This has the useful side effect that the QCryptoTLSSession code no
> > > longer needs to know about all the different credential types, it can
> > > use the generic pointer stored in the box.
> > > 
> > > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > (..)
> > > diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> > > index 5c55b07b2f..0a728ccbf6 100644
> > > --- a/crypto/tlscredsanon.c
> > > +++ b/crypto/tlscredsanon.c
> > > @@ -36,6 +36,7 @@ static int
> > >   qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
> > >                               Error **errp)
> > >   {
> > > +    g_autoptr(QCryptoTLSCredsBox) box = NULL;
> > >       g_autofree char *dhparams = NULL;
> > >       int ret;
> > > @@ -43,6 +44,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
> > >               creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
> > >       if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
> > > +        box = qcrypto_tls_creds_box_new_server(GNUTLS_CRD_ANON);
> > > +
> > >           if (creds->parent_obj.dir &&
> > >               qcrypto_tls_creds_get_path(&creds->parent_obj,
> > >                                          QCRYPTO_TLS_CREDS_DH_PARAMS,
> > > @@ -50,7 +53,7 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
> > >               return -1;
> > >           }
> > > -        ret = gnutls_anon_allocate_server_credentials(&creds->data.server);
> > > +        ret = gnutls_anon_allocate_server_credentials(&box->data.anonserver);
> > >           if (ret < 0) {
> > >               error_setg(errp, "Cannot allocate credentials: %s",
> > >                          gnutls_strerror(ret));
> > > @@ -58,42 +61,26 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
> > >           }
> > >           if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
> > > -                                                 &creds->parent_obj.dh_params,
> > > -                                                 errp) < 0) {
> > > +                                                 &box->dh_params, errp) < 0) {
> > >               return -1;
> > >           }
> > > -        gnutls_anon_set_server_dh_params(creds->data.server,
> > > -                                         creds->parent_obj.dh_params);
> > > +        gnutls_anon_set_server_dh_params(box->data.anonserver,
> > > +                                         box->dh_params);
> > >       } else {
> > > -        ret = gnutls_anon_allocate_client_credentials(&creds->data.client);
> > > +        ret = gnutls_anon_allocate_client_credentials(&box->data.anonclient);
> > 
> > Pointed question - where's the object pointed to by "box" allocated in this case
> > of an anonymous TLS client being loaded? :)
> 
> To be clear, that was supposed to be a humorous report of a regression introduced
> by the above commit - sorry if it wasn't communicated well.

No problem. I understood your message, I simply forget to
reply to it :-(

> Reproducer:
> > $ qemu-system-x86_64 -object tls-creds-anon,endpoint=client,id=test
> > Segmentation fault
> 
> The above code branch really needs something like
> "box = qcrypto_tls_creds_box_new_client(GNUTLS_CRD_ANON)".

Yep, and even more importantly we needed a test case in test-crypto-tlssession
to validate this works !

I've CC'd you on the proposal fix


