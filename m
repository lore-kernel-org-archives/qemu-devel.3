Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC8CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQI9-00014o-JI; Wed, 10 Jun 2026 17:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQI0-0000kp-EB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHy-0007J1-RF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mjox6hOLjpu/qh4iYqGbCY1eM9ociLNT3YINcoqRn0o=;
 b=TlbpvBRVx4da0aLWpj6wKA707yUYH4H+7oyvPl0ficzlP+04nP6u+L5FgCgV0DoURB3Atv
 kyGJ2QzYFtBG7RICHlkhoMFmaZ+Kdjpz7amzWXzNqkUhjYh1uLk+utJTbc9sHP3JhOpSwy
 pfseyeiMwOn5GlQrk8YeoqdGe5nWvCY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-uQZJZtScN7apYmv_1gxi_Q-1; Wed,
 10 Jun 2026 17:16:39 -0400
X-MC-Unique: uQZJZtScN7apYmv_1gxi_Q-1
X-Mimecast-MFC-AGG-ID: uQZJZtScN7apYmv_1gxi_Q_1781126197
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C471919560B1; Wed, 10 Jun 2026 21:16:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C26C3008B36; Wed, 10 Jun 2026 21:16:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 31/35] qom: add method for getting the "id" of a QOM
 object
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-32-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-32-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:24 +0400
Message-Id: <178112600400.209622.3065709276056576577.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=841;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eD4GPLeEHRaEgud/RIibaxnqqJzaR6T8Ru4L7jZPAXY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOGUdLthJvukqXUSL6i59jGCj3GOMLmYWoDt
 iNEdiu0RLiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThgAKCRDa6OEJdZac
 5SNoD/9vew6o16sZdO3/LTJqWz8jYHB3tpxS1UxOuTPp4/yEf6TktTMM4BnhGGx/nr//uWx5G0v
 3TXeXwBHDfWVoSpfIY/CETm4a963OsJip2jn+XlFOyRem78sADp3V5iy3zSyY+tjzDqzKTfFfcd
 ZIaGtACkiC0Jv3I29ofOZE/BBpDIe2Cg6ZFaegilbBP39Bapbhovs8NlPmThqJum+mALBx/ndBQ
 PV8A2dgXRpZC/CjFvD+b4demZitiPa6v1XKIaXcY1UApiy595LRdBxxptdzSmzJ4tQOL3WKiAnE
 buZWR9KsXCmo4np+BiDJ+MNmopg3Z4EpFfpjyiPmklrRYd6530l2hEO/vHfRn4wzhmbDGdtyXCT
 MeGjHRTRyQmwLF576E1UHRAsaA/FUrjh5S9NNjTVhbKifEaJ8lvOGVlWPoagFoKSGrNVtAvHINB
 VyPZi9yT7KxsXTwDKVs6k1PMEq7d5hYDBmZOJof0yyq1GBYMONDH7bXwiVHVztmg/CACoaZ2g4i
 QjTbYwdrufnnLbMCNcY+aQXmRyDpqqR/o5FdUXa7U2YHGm5EKpzYChrI3zNx0YzLEhBLiOp6HE0
 9cJzSVpnNFjHOj2qDn6xOpaa/H5PMSdVVO0USAbSRA2hnMN396ACTMnQ7Oz6g8wbGPavarGGwGh
 PrQkZywNP0GuR9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 10 Jun 2026 13:34:11 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fcd..c828ac63652 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1759,6 +1759,16 @@ ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
>  ObjectProperty *object_property_add_child(Object *obj, const char *name,
>                                            Object *child);
>  
> +/**
> + * object_property_get_child_name:
> + * @obj: the object that owns the property
> + * @child: the object referenced by the child property
> + *
> + * Return the property name against which @child is registered
> + * with @obj, or NULL if non is present

"non" -> "none"

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


