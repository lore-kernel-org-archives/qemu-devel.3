Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58265CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQGA-0003IQ-EL; Wed, 10 Jun 2026 17:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQG4-00036Y-K9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQG3-00064s-2c
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3xHpFwJhxHMSS32QSAr09x+BBjMtOj8kyykMu3GX68=;
 b=NHGwUnZZaQM5OfPb2zS+SmbS63UxT+1KkznjAa7Ljr4dU5S5nXiBTDWDTPo4nAxHxTuPQ5
 YFF//W1xLL9+W84SfXR4Nmli8zcJbRzuPC+sKDvNEQsamKhqeDJWhxBzjTMC1y5xRGiu3S
 TisoDmCp7rROQ7qXka68+z8e1dhkLTQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-vk7HlJwYN4q7bXNl5pA8ng-1; Wed,
 10 Jun 2026 17:14:38 -0400
X-MC-Unique: vk7HlJwYN4q7bXNl5pA8ng-1
X-Mimecast-MFC-AGG-ID: vk7HlJwYN4q7bXNl5pA8ng_1781126077
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B10218E6A65; Wed, 10 Jun 2026 21:14:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3658819541B0; Wed, 10 Jun 2026 21:14:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 09/35] monitor: remove 'skip_flush' field
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
In-Reply-To: <20260610123415.2883603-10-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-10-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600332.209622.18425464584620283795.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=697;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SgpMdbt33t6NVAiOB9blpN2Igpo+vyoAECYdJGi9+Yk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN/VqDVVZo2pDG+F39Y4Mpk0UaIxOUP+0Raa
 0nRF+TYX5CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfwAKCRDa6OEJdZac
 5VlqD/4wkY0zuxEyXPwp8ftuQH+U6GY/28TBD/lzXMF8QWEJ60oeDEmmhbGrFqrcp0wE1oGm+Ho
 tvW0cM2OfMWFn1tRKUtbsYP2KgX0pm4WGcTemwMfbUSyBUGsKj9rsywEW2QFUi+OQYuEsFW+K16
 Ix0XmPtelW8kHVEAtdBQDC+ZfCHCQB0j7vCR2B7u/ESvhSnfTqteSd2vV+u79xNlMzKQ8hVw//A
 6TDKSYZ/NhiaIPwb8MFiWD9V/iNelnPwRCz4z0d6VS2KGq5mJCjM0WTQH2eajKcm7bC0GKgyzX6
 8IQ62cGnHl/qDvZZrNut23Q2XUKv9xQJb9C+65wBMHiZAb1sg9aZc9OqMUozZySzPBbOeLD0dks
 vZURcPD4+inUAYjCbgPOPbf7ZaZxzKZpoD01xf6T5tC28QYFQ1klWsOODa+69i+LAlQ15E26fi/
 f9lY846FwYjZxxHlpr6uAL3/WaJuioqHmSca4savpQN6/AGvvJFsRIHSfEqfLjDQm9PeuGzULe5
 xzyKiOeP+eCensAtDqEPpVVdxuImDs8PfzwUcTUBEPb/9CGIQj1yRa9IjmiAdBGCXRoc25osi/B
 gRo1/1t98uh2hflM+5oTVtrYhrbuzWYrdv4lz363ORIiU5Me5niuBNPGDiWaajI5zN7T2D1OlFy
 jGf5tnqleZ23Rqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, 10 Jun 2026 13:33:49 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The 'skip_flush' field is set on the dummy throwaway HMP monitor
> object created by QMP's  'human-monitor-command', as an indication
> not to try to write data to the chardev. Instead the QMP command
> impl will grab the data straight out of the in-memory buffer.
> 
> The flag is redundant, however, as the monitor code could instead
> simply check the 'fe_is_open' field on the CharFrontend, which
> will be false in the same scenarios that 'skip_flush' is true.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


