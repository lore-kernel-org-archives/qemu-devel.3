Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A392C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmC-00046q-71; Wed, 09 Sep 2026 16:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmA-000433-N7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om9-0006uO-Bm
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/NfR+NWmgt+0Um3wDOhoy3qSX1YBnwIeY8ZIWJeZVA=;
 b=OeTRJLssjO2rdjZKqpWTF6ivi31SwyF3752RGGsWgIgG1w95H3MPUYKhYPEEKy8tAe+MRe
 KjJ72YkgMqL5PwcO8202dTmKucM/U8l5h9j/CXvpRqTGoAJEf1/ZbjhXLFoyhsWnoQjf5n
 GDZc+MRrP5nOj/PMYvCk51B7YUUJqsM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-QQmLQKH-N7S0YDwwxNzxgg-1; Wed,
 09 Sep 2026 16:20:05 -0400
X-MC-Unique: QQmLQKH-N7S0YDwwxNzxgg-1
X-Mimecast-MFC-AGG-ID: QQmLQKH-N7S0YDwwxNzxgg_1788985204
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3271C1955BCE; Wed,  9 Sep 2026 20:20:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 296B01956042; Wed,  9 Sep 2026 20:20:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/14] system: check security of device types
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
In-Reply-To: <20260909175656.1572689-9-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-9-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517058.2613908.10918039445386085322.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=307;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/rL6rU2JOCaHW463fEePtaUn2j+cwRTp+8NR+EWVFIo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9VPM7q7+KUrjPoEGHnqKdi1syUuHgXODLWT
 6Hwu45SdOiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5fCREACVm6AWJtJLCvyTZu0JbysWf/Hc5qNfRRuphcHYPYtLf6e/YGXVevGbvyLyQD85MiCFX74
 kMNKTOzITBU/cmfkRQvNnEBbfQ6SSJNamDxhTfhfb2NYeGWmyyz+ue83NlF9f3CQTBKE6N+C4MY
 4DE1G12dl2fxlldu8BaCHFmg+FT5p82Mh2NR7EvVZ0Lb9a5UpFjF1GXg8g0APm93KRWNKhX568I
 l1DL8plocFfvq+XBla30ufGO8c6uymP07zyGlnZFwkF5xW41S1gdY1JXyx/1RjMqE0V4HEwUgVi
 fBum21+AcIQflAW/UINsfiwlukpunXSkoNlm1fYQAVSb6cF5ySYrtuNK3d40wyd/cvKb63k3+Tn
 pxrLusoYhuIZgfTULw1w9PAlLtB712vLNYGcDWI1WF4QKynDSVCbxIIglG245k3o2hZ+23Ka6Eo
 mzkk4jQHnQcCeMHXBHCAiivScXc0QOha8iiWHbFaCB1iTkE8t1713FDznHyyDCsvgwbjxMK9DnJ
 bMZPdyB38EwgLgKwKyQR6DnPmxjyZmznf89JAtT7ebJCeTg1ROv8oesVHnckbngoRgDJc6cbzmh
 d9pM9reWaD4SlC7jEDWWZEX5deXOJK6twOP3Kr1iADoGALWu+6x4J5JnOTrGtQ55FA2deDD63bN
 pSUFSUgoNEfdMjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 09 Sep 2026 18:56:50 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This wires up the DeviceClass types to have their
> security checked when devices are created.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


