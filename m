Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A90CCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQII-0002Ky-Mv; Wed, 10 Jun 2026 17:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQIE-0001fu-25
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQIC-0007Qm-F8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwrB2yeRKJ5/wwIGnb74b2F5/Kib9gybbFLtk385kIQ=;
 b=Sf5zifva18ATJbS6UZPxqKS5wYKGe6rcnBsnDIZi1dg4efBNYbOsuF1kKM3nIvpEmCreOi
 uu9NcPuP+Ep08SknU0h0LbDBfZjzRnDN8eSjvKH5V97fIfD8YI9ohdLoM9Dg/wvnM1La6T
 1paXrSUMTerqtmJBYEilvQDZnrD4Oek=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-hrM2YSNgPo6nNW2Wwd5GJA-1; Wed,
 10 Jun 2026 17:16:50 -0400
X-MC-Unique: hrM2YSNgPo6nNW2Wwd5GJA-1
X-Mimecast-MFC-AGG-ID: hrM2YSNgPo6nNW2Wwd5GJA_1781126209
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21D60186D577; Wed, 10 Jun 2026 21:16:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE98B3008B35; Wed, 10 Jun 2026 21:16:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 33/35] monitor: add support for auto-deleting
 monitors upon close
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
In-Reply-To: <20260610123415.2883603-34-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-34-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:24 +0400
Message-Id: <178112600406.209622.17677163019319157418.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TCD0RzTj9XvwcqaUmQI/2b2danoARt1XMV+8Gxk6D/U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOGczlD6K56S2w5xEBPyStet17ikT3Op1FsR
 elemTXshkaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThgAKCRDa6OEJdZac
 5YJqD/0eTS06mE2Vh9r4Zfl4SIxCth0zGribAlKYC0H3HNVLDFlHIBdEvfndHVIs/YRCD+IG0xl
 hRcXq4Ja4LskbU6vdCbGOM/wUXxYvMxlalzKrWwP3kzwqVFFB9HXgPcl27EVhjvTNGpWyosXNul
 eR9G/E7Y1w5LeX4aGuxaUUEtbB2GcDq1K6PWT5UjanqNB/DXoor11e/JGG0Q3l/dSU91zvcBnGT
 G3/5cy5GAsqarb50gOresVJ5m511ObI/hohbi/lJo3V287vUkKJOOY/4g1l50h2pm9RIFr82AwX
 F0CSNoV+YLR36yxtjYIvOR/0+QQY9dbXnN+vy75b6jOt0YO1UW+xqN6l4ig12PhErHU2B+QhKL0
 /Vb2Lndqx2O0AoS5J5RHtojHsK5IPAci4OTR2gVIRlm9GmoelOMbNBArZa7MNTlN6nL0bnTshuJ
 3XoxVGpJjZRdpI+rbxxtV66IyICbgcOR8AauUsC3wiwNZ+2pIr1yfZ6ZiINxtN8bqj4SmZupWQk
 EY1Atu9+e1+zs4sRmCwlYYjp2cu6rm30JkXr0p7bA8QkpCivxlo8skshtfqkb7MQVXp4DSBlxD9
 47jjqB1Hg1lLUsur6A8TsqcZwkUTa4ZM88b23rfByaRrnyujNBn82rsHTOxK1GeTRab75Uk+Pqx
 usqaW7HW8TqOo0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, 10 Jun 2026 13:34:13 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> index 03087faafc3..f7d72a77c2e 100755
> --- a/tests/functional/generic/test_monitor_hotplug.py
> +++ b/tests/functional/generic/test_monitor_hotplug.py
> @@ -118,6 +124,45 @@ def test_self_removal(self):
> [ ... skip 30 lines ... ]
> +        for i in range(10):
> +            cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> +            if 'hotplug-chr' not in cdevs:
> +                break
> +            # Sleep upto 1/2 second to vary the races
> +            time.sleep(random.random() / 0.5)

/2 or *0.5

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


