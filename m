Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060F5CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBKu-0000jk-2G; Thu, 18 Jun 2026 07:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKs-0000jZ-Mq
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKq-0001CZ-90
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp/6Ep43YURgyjkbXaEE/cGTncGiPC80A2oQfP79Wts=;
 b=YEn6Uxh2/Xa1GQB1ztAZh/AVUNQvqD9I0c59AmDt/4YXiTAOO/cpbjNLY+OV5R8sTOFYQ3
 Oi+BIEpUI6xUTse3Z79TBzFEVw6CaWbIhLSluGGuyD74cAfuEOX8OEgGtcsK88pvH1C+zh
 9Rk8/w9rzXkNkYWCjIbjh6nIci5nzMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-6nVmPFVDO3WhtxSIN8uSuw-1; Thu,
 18 Jun 2026 07:54:59 -0400
X-MC-Unique: 6nVmPFVDO3WhtxSIN8uSuw-1
X-Mimecast-MFC-AGG-ID: 6nVmPFVDO3WhtxSIN8uSuw_1781783698
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69A08195604C; Thu, 18 Jun 2026 11:54:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF1131688; Thu, 18 Jun 2026 11:54:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 30/35] qom: add method for getting the "id" of a QOM
 object
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260618105836.991609-31-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-31-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367256.2477794.13374792186168772539.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=652;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eKJY/eAWAk+LAo306XonWudCBJ20GCpgHjcc6sGn2Y8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7UR9utVAL5gqp1E3R9cHoYJgO60CgVkUtE
 ws42w98L7KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5fB9EAClXdTGzeBipjB161ROrpexkGwVt5wlIIe3NOD9y0QaW71JhVyX7mkeNDBKPmvZrZh6+sV
 ViuZ1If9A+Ro7ZLlGv6MAF5vGW28gp9vUp3Fvv/JUJL6tNZTO3DCsmjMUBiHmcjB/4rfo2Odpby
 Z8Kpcnq7yxFmCTsECoCkBy74W/lugs0XEPKgzlUTHNACQ3caYTH2K0XoJduSAZuNna7RG+pI6Lu
 1Q9Pb5cjyjjsupLUZIMKIrqvvoKNmOWO3bb6bW0BJEqBu7D3aVwJDfe28bEKApYjYLQ0KzZD1fZ
 DEb8eiJlrwo1j7EGYVcCwOFxiExDKr3rYC1oaQhzXo09oQrEa93l+qqP5NXHO95h8iZy82j83x8
 nVFpjjhn7QTYezoYGDSuB+DO1Y8T0+/oTA1KXMsRzVpZMLY54RZOTFh0StDqwP8faa4U89yY54Q
 JWljn+tRcbj+mJx9zAjPcUTWDZajfihDzT2yVwhxLG0WTDaXstgF6Rli8moRqOztGagjbdqISsd
 LQS2Q9Qnon70jcmyGEDL636FY8vuHRsx60k0c5XmUvInDEbYHdUqkc2LoXngMQvMpSBHHszYzfz
 8/2q/c2hK/XJ1fwRRjT6aSxdSpJtmbLhvNRvoltIP9qdJkicAwLccDXut8ABEN0aRWyd/cMB+7D
 Q09BesQW2qgGohA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 18 Jun 2026 11:58:31 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The 'user_creatable_del' method doesn't want the 'Object *', but
> instead the "id" of the object to be deleted. While most of its
> work could be done with the "Object *" alone, purging the QemuOpts
> values needs the "id".
> 
> The "id" is not recorded against an Object though, it is indirectly
> stored as a property linking the parent and child objects together.
> Add an accessor that can fetch this property name.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


