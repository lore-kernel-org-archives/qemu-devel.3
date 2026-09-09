Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D8AC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmY-0004M6-Mr; Wed, 09 Sep 2026 16:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmX-0004Lb-3Z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmU-0006zr-Q2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rFFQOw2sQsK5p+1iuRHSyiqmx8ONpFru9lHqiA2xXg=;
 b=hDcGYOlPkIAwEpVk6pmJm4DQRp4YPV8PnssmniLLnotvrykzsbnmuUVYrn+w3S1IHuGhan
 T/mMR2vKtTJt75i7B6N3OGhofUkCNPjO3y7qhjruhrplR8mIn6WNZUud9Ap5OetRAvz9yW
 4Ril8s//mpePVzrbD6s/9T+rd3GbpFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-Wit3fsSVOZWNKR41tU8juA-1; Wed,
 09 Sep 2026 16:20:27 -0400
X-MC-Unique: Wit3fsSVOZWNKR41tU8juA-1
X-Mimecast-MFC-AGG-ID: Wit3fsSVOZWNKR41tU8juA_1788985225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4CEB180060F; Wed,  9 Sep 2026 20:20:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 473A630001A2; Wed,  9 Sep 2026 20:20:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 14/14] machine: add helpers for declaring
 secure/insecure machine types
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-15-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-15-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517060.2613908.17232025473511543859.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=739;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FX71RBpvM715juFzLEQPQDEq7wmqJaIB5USoHhoUZDA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9WIBziAhf+jnMKFCDFhHeW7oM279RjdBqoy
 pd1HXBM7AmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5SKpD/wNaXddCK7nP77qoiPA03uFyNbBvvnHGVZRcjocZAs2r62J7RYKTELJZW4YvddlVNoqb+o
 bnZBFHkPh7SjTOYNsTTr903mJ2NMLKK0q6sCijdSwXpNlf9UnL84LP8YMz4pEM7CgD6b2++xXXi
 hQP8UIiAu6qP5RGabxOsJrWU8KGpJyqzgv2ZSsk4XySbPgyv1bc2EQJAgX3GnWO8tlgw/JjKEbp
 ziAHiqxivBTIOAFIITE6tHBu4T5LJPIAyy0QVfqWa0uTEf8Kqd7U+Vb/3U/wnS7w4KhXISL2lG9
 3gx/DRtvOLB1z9DS16Z1hsVZFP30oDIGCiyiW+p3yEGMn4gKz3PVZFBmtl+kkSVUWEGABRPza+v
 +MRNeL9DZfTgmacsQIMsxLzodpTBjxd7RzVlT1V2hFkI8mn6kP3OhrqAPt4f6meCbWZGykGAfE8
 1WoyUjPaOroSmxhu4iKHhUBiGUre/cDj6dSoMJj5hrXl/FutcqAuL9NocFM1qYQv6Jbzy7W3x/A
 HK855ZT66Gtw0ZflNuA7DUSOCmBi7A7p64PMViT8tUUGpD40BiUqXwnbJyqypm0QhhLfwOxBVAS
 bbHSRa7ozSljz0rsmCuPB+wycsafAR+IRf3t1596zDlJ8zNbEqGxiOuzaTfAftilohACdpTwScs
 BNgPxpd2xpgzdPA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 09 Sep 2026 18:56:56 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The current DEFINE_MACHINE macro will declare machine type without any
> explicit statement about the security status. As such the machine type
> will be treated as implicitly insecure at runtime.
> 
> Introduce a new DEFINE_SECURE_MACHINE macro (with variants) that
> allow code to make an explicit statement that the machine is treated
> as secure. This should primarily be used for versioned machine types
> that are intended to be used with KVM, though some others may warrant
> a security declaration.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


