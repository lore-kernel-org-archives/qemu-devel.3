Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D86CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHR-0005QH-KD; Wed, 10 Jun 2026 17:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGr-0004Hp-HJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGq-0006pp-1O
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsEOMYmFkma8FiYontBoeZ+30xxpP0xCj8yjKrRewa4=;
 b=Qx5HKmq1Mx+hNSdQ+ildfppb4QSNfyCdc3EPLhXyRKrwBbC5GtiScmHQaDO0cJ9FAsdnE7
 uU8YFVxI51AE7UJMfAEjwwwJ3+8PlQvfoyECagRG2dLLON6pXaBnxX1Ohn9Wl6xp2E0WtB
 h4bD30o95Qsth/0kjr4pkkK3AjiP+R4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ex91NPztPHmVoyUzErgY6Q-1; Wed,
 10 Jun 2026 17:15:17 -0400
X-MC-Unique: ex91NPztPHmVoyUzErgY6Q-1
X-Mimecast-MFC-AGG-ID: ex91NPztPHmVoyUzErgY6Q_1781126116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541D51977033; Wed, 10 Jun 2026 21:15:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08B3A1800347; Wed, 10 Jun 2026 21:15:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 16/35] util: use dynamic cast in error vreport
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
In-Reply-To: <20260610123415.2883603-17-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-17-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600354.209622.11107889906556113615.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=287;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H0lMJYkZIRcf0LVa2tzFwqnJSEwzMNCK2L6d4uFtXUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOBpxb//OFXB2YcPZDx8Is97ovRTrPqABYmx
 cQY/MQ0yGeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgQAKCRDa6OEJdZac
 5VDXD/4njSn12HjMPwFpcbonpW3TMX7rCryphRcW5nJNSipf1vaqaGAv+tlzWigR0KMzcwd/g9g
 nDCwptrPytCGwtoYJNDDDVrLlsSi+TjYO/SJ2znJg4flU/mTlyRRSY/6VFD/7mwhRrrvPqPX37D
 L22PfZfwn9Q99cmnqz4deoZcGWUg842eAZZD58C/s0uDGIchY6vXib4og+j1kBKv/Xw00XwDUVL
 Yo0wENGNcOTuVsvudTHV1cPsekAPIHSWLpvbxxsGD1BGhfZJPBBfq3eesb7pRHEGl+2P6NWQGW3
 Eqo+e8ddjkIwXyJJsbdDPEmSnHDM2bsc5X2qUlcZhAxlRf4qQTFjPDNVLcLFPMaJ/DSyJS61Alv
 rTJLpM4sAyTJ4xkgDAu9U65oN0zJopBEe/FKq7sjb2cQw+uKd65nxeqxEB/MhweDOlSMDP5B798
 2mF0eP/Ur/mE+4Y2tFZ5wOIQqmtu5dtN48w9L7Gh8WxsQx5nLobZA1ZAEKFJmKhL69/D3A9mROw
 M5hoqmujNUaNuuZTiF31InFP+BPto+YZQJj6jxsyYNA02lMOIWbb0Xey1YLPgTVn90uZSJAuGUQ
 pCfL7iXQIgICj3schKlXkYZLGj8xWHLqiINYibTiBR8agq+/g6siOGjFpc44t9ORks6NDjf+Z8c
 V6LS81MwWloYlog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, 10 Jun 2026 13:33:56 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This eliminates a use of monitor_is_qmp() from the error reporting
> path.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


