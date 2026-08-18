Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9511EC5DF8F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQK4-0001dU-Ae; Tue, 18 Aug 2026 16:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQK2-0001d8-BS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQK1-0001WY-0H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BtHAcISRyJaoy4zpRlfu4W2ioWU9XgbRzALfQ+9H7BM=;
 b=AQ9q8rUtMaDNM6Epysur3p+Pwga45b+BBeMVZ/xW1IMrIuGX8OYcg4A1iGHLuwbiQ8IT+k
 XfGmn4ep7WWGK9Fyb2YthXiE+zI3EZ4nx9c67GMjZ+IpQUV2n251xW2M4VKn8KEq7J+PlY
 3VSxDPiTOcstteADgBCSx2uRltgNhdU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-x3M6LpX7Pdua3DkyDZNTiw-1; Tue,
 18 Aug 2026 16:22:04 -0400
X-MC-Unique: x3M6LpX7Pdua3DkyDZNTiw-1
X-Mimecast-MFC-AGG-ID: x3M6LpX7Pdua3DkyDZNTiw_1787084524
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A591955DB0; Tue, 18 Aug 2026 20:22:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B747B180034F; Tue, 18 Aug 2026 20:22:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 04/32] system: check security for accelerator types
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-5-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-5-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450916.1320462.9696296249019752826.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DhxNIB0lH10AFUK1ZO6ITs0pXlZDsSc4J+DpWf+Z8C4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7fC6cAJZXhedZnN5NLcM+HSdsBF7dtQvsqc
 kHM+R3ZFnyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+3wAKCRDa6OEJdZac
 5ZPvEAC6p5ejLMHJ8fMeKWL73PbCNZF+g1Eh+Sigkj6jgvMFBa/WczT93L2jjTCwQXto+Mqk9LX
 6GwB6NWI49XgICMIHGipwFxrFVfSTFhM0dPEy/Y9YwUifEzoi+Rxz+FFB9Xn1F2/PMRtQT6WSdz
 x0hMOY41QTmgXuBi+WEYZQ3c1IfyQ45rmLh1/S3Wd36sTEaGRZ23cK/PYoYlsdd6z6mcClnGnV4
 WCOO17gd0q5NW+jTzxb5bBlbBN3rXXJJV7Skek/81FOkChpLDu/+WmjtWq1g23N2vSWaS2JYCfC
 w0afrKZfXvQcs/iPwgNI7XQccN802Z91LqPoJCzMclnMEtbLLcb7KEAGqyYgPKc5nbkc57pWt+Q
 x8pFoFaL328MfcPJlazLrdkrKTPIvkCDeQu93Ty50GDF2l40D11tlKaj5JPkHE0CtT7SeDbv9+8
 JZqULk9VCUtAHYxhvyeNFz4L3gPNIw5A0HkfESbf21CXnDu060MENOxnVoWJHbrez6B4a6S3Bgb
 PdD6s2ktGFw4M0wXATmJU3DAo6M0j15GTaiKWPJh8p8AsW3XJxyGSy+ehAqG1xJ1H1t3RZDFMbU
 rRnTdIiAHXQxUGEOSpJCxmOjzdLo9Q+VjoFXtX5Mt57RK/6/4cCyiZT9KnP7KyrBjtpwVNt+/6i
 BuHPYgyvyvN8oIw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

> This wires up the accelerator creation code to apply the compat policy
> security check. When multiple -accel options are given, normal fallback
> logic applies. IOW, if one is rejected by the security check, it will
> carry on to try the next accelerator until one passes the security
> check.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250926140144.1998694-5-berrange@redhat.com>
>
> diff --git a/system/vl.c b/system/vl.c
> index 00f36947257a..6f7fdb866359 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2383,12 +2383,21 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>      AccelState *accel;
>      int ret;
>      bool qtest_with_kvm;
> +    Error *local_err = NULL;
>  
>      if (!acc) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "accel");
>          goto bad;
>      }
>  
> +    if (!compat_policy_check_security(&compat_policy,
> +                                      object_class_get_name(OBJECT_CLASS(ac)),
> +                                      object_class_is_secure(OBJECT_CLASS(ac)),
> +                                      &local_err)) {
> +        error_report_err(local_err);
> +        goto bad;
> +    }

It should handle ac == NULL before

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


