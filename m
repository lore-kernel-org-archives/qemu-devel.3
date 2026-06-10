Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4935CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHc-0006HN-W0; Wed, 10 Jun 2026 17:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHR-0005Tq-9l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHP-00078B-UA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhPoTFgKLbLIePU3CTlnXBzKOnHrni3ctCkA6X6Vz2k=;
 b=Ir1zNELHmn3k/nrQHApTHMHs0inN1idWTyuxA8Q/m3erfdLFh6DF9TF5QH+YE2alLnuvKy
 x2q1npw3ICh+JgoiUPC6XgnRyrsrdxdsZ38ZZg1In67wI+RK3CminvBEx0qNKSHc0YXOMf
 VbPbNvESaGkgi7cTbue0OBXleXSYjh4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Kzy8oHtFPDW8Ls4s_QyZoQ-1; Wed,
 10 Jun 2026 17:16:06 -0400
X-MC-Unique: Kzy8oHtFPDW8Ls4s_QyZoQ-1
X-Mimecast-MFC-AGG-ID: Kzy8oHtFPDW8Ls4s_QyZoQ_1781126164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD2A71964CEA; Wed, 10 Jun 2026 21:16:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86CC73008B35; Wed, 10 Jun 2026 21:16:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 25/35] monitor: reject attempts to delete the
 current monitor
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
In-Reply-To: <20260610123415.2883603-26-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-26-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600380.209622.16589262874921465560.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qm2rM5pemQKV7scOFBMyZKbMq2CQDyB8uCTPOr0c2Gc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOEgwuXpHH9C/axJHV73O4BZ38l9Idg15J5P
 9zjlUykYD2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThAAKCRDa6OEJdZac
 5d0cD/9Vzme+A4cInzjW7nZjNPM6i0SdmvfPl6pYajRnK3pFdhqV0zsn4EjC6kBefoNmRBMugf1
 H/l99mYH3IbiG264OTl9QkoaKJTCSzlfNgwwKybjSg41p200If1NKIhwQRY75gAygawoe3neaPb
 JGAmQgZNOqNah6hM3ndB0PhoB0XLmD/iBmfvbXT2KHKEFRRYULG78Y3fJEUacE9kvrB1MZqtXgq
 kxs22ji0MrdS8obkIOqpM+XL//WqmXOZIhruMU1dAe6mJ4jaUtOCgzATZHqCZtalYpSYmbo7vbh
 zjsjaopzePvznpjfof1jR6UKDD+uFKEBMf5vVYv8GYyLSC7dOCabJBZKPP/geGvZp525V7097DV
 AHKA/QCiS8Em/GudU2UYxqOtNGliWi2TTC+jzveSg6BaQRSeXNS3W8m1WgbBEoEsDOP6QFxlHNe
 XimaPyAQ9hnGm7CraDXh8DMYYgunft1LD0LpAc6O5S7P0sZLKpTOzYQlY0qGoSjKXPQmNxzhEIy
 S5KKE24BEMPScYn72J1L6EpWVYO8+dylynJDXBCYrZZpROdH7X+npH2d55dKqIb5t9Cj1kQ+uN4
 +oEU6Zt3JD8yqjXQr4DH/lZoWPKrlbacXeHkHMpFlISCjOGbjwfcWth4hnSwAZcCg2a7C8VfEdw
 xzvd5rKztqGe7xQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, 10 Jun 2026 13:34:05 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> If an 'object_del' command for a QMP monitor arrives targetting the
> current monitor, reject this request. If the current monitor is
> deleted, it will be impossible to send any reply and the client won't
> be able to remove the corresponding chardev backend.
> 
> Note, it is not possible to rely on checking monitor_cur() because
> if 'object_del' is called via human-monitor-command, monitor_cur()
> will reflect the temporary HMP, not the QMP target that needs to
> be checked.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


