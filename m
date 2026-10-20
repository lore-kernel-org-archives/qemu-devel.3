Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEE606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiIF0+uk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCCm-0003zn-3f; Tue, 20 Oct 2026 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCl-0003zf-ES
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCk-0000ms-1J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VE22xbP8s5yqzpOboiNCpq5AUhkt3iJZuJnBCk0TuQ8=;
 b=BiIF0+uk59aI36LSBMQRNY4LnP9wtM7qfZ3rTTkcETKpX7GmBLB4LvL0Y+NKQP0iM06NT4
 glOfptFg4adOV7eC7Xf7Kw3QlQj/2fbRvtJ2CknduzFswbVL5nzdfc0PUxRXo1B9AFRnQX
 DfQCrZUjTAIqCy/NGbeKUl+hfkM9F9Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-USFPJ525PxuvlW4ZvHOw7A-1; Tue,
 20 Oct 2026 15:56:40 +0000
X-MC-Unique: USFPJ525PxuvlW4ZvHOw7A-1
X-Mimecast-MFC-AGG-ID: USFPJ525PxuvlW4ZvHOw7A_1792511799
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A21941955F2B; Tue, 20 Oct 2026 15:56:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67577195608B; Tue, 20 Oct 2026 15:56:37 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 05/12] main-loop: change the handling of SIGWINCH
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v10-5-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-5-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177296.3780647.18187135044971573699.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=360;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Kt1GkmHwRzntejMW1vAAThU1OwaCUA4Ywk/utpFdY4I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148gPEJmR1dpap47j8NoobRQAkUjM6wahSH6T
 pcB3srfYPWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5TyFD/4/AmjkS2GsGvWYmEgEBx6qfLGMzH8VqvDm3dWVVPqpGrY0W8MOFO30ox7xaXSj46eo9tS
 7vl7J05+1GZVQPC4epMr8mN1S9quZcJes8cDcai4bH64JZe1L1QlAerHBlGaQT1+XRC7dg8NTk0
 m2e9sjHYFj0OcWkOk6KS5VkQubyTG43RmIytKEFueGX+Y4tviF12xBfVdoGCqQtAoDZ8eUooA7B
 3pAPnhs6yjVoRshidEUYYe8S9jbIjKHIRTGGmOd1DwBpNIGeKbPcRc/Fja3/CdhYQT3voR0b3Pu
 +oKJi/6Uq3HSXtVjLIn4J5Bg86ONUjK4+BOs2X+QxgrsuzNz5NAPNjOGcFhOkUYprlf2UP3z1Ej
 Eqe/LmmfjL8O9LeFtBJi4HLAlxhOnC6FFWnGVHwE/dHN6iVMBOx25o2fGNsPb8y3jN9cMs7jLzi
 av84kg8FbYTSCCQvhAvpGD/TDCK5DSVsVlLbOD7hpY82lYLIJZvDj5BnErSsIV+1hmnfnvajYIA
 DWpKmlqL8Uy/4GdtLajGjcE4VRGqAC81rZzUSc6c278ZaZ6uzZB3dXCSmsMj2+B5FT4izpSjd/3
 9gQFc5KVTe8J1gMDGl3DLGz353gVlKKfRFB9feWqcDoam+mC6FHbV1Wc8NfDqp7hoUO4suTTUUD
 h5QEfATcakkYtpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 16:05:04 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> Block SIGWINCH, so it is delivered only via signalfd.
> Install a handler that uses NotifierList to tell
> interested parties about SIGWINCH delivery.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


