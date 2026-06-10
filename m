Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A3BCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHa-0005xV-Tk; Wed, 10 Jun 2026 17:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHP-0005RH-GE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHO-00077E-4D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wO6ZZMZ7zsSySbALtqDdW8N7R4lVeA+OPHkTOSLxvk=;
 b=blp2C6V1qEhWz/7Uioazw5jGYoG1TCnyio5b/1SlcTHNVzlZFgU2hNECCyv30gLph7PI4g
 XawLfUWSQIr20/huJoojolVEaVFaW/6l4lJBpbb7f/yL7IFEonCWvId5KbAWBR6JcXsWt4
 NWn11NTejH+MlZQfGibghtrEZOZm2DM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-H88llDAKNxinWmnvKd-ArQ-1; Wed,
 10 Jun 2026 17:16:01 -0400
X-MC-Unique: H88llDAKNxinWmnvKd-ArQ-1
X-Mimecast-MFC-AGG-ID: H88llDAKNxinWmnvKd-ArQ_1781126159
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40AD818D958A; Wed, 10 Jun 2026 21:15:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CFCC3692F; Wed, 10 Jun 2026 21:15:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 24/35] monitor: convert from oneshot BH to persistent BH
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
In-Reply-To: <20260610123415.2883603-25-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-25-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600378.209622.14422701567890356564.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zjfxo5rURnG/5GWzXzrDIB3ZCBQFcCEBxeQn15iICZM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOEagXvOVVB2pkZCEjf2aYoxXGM3k38mwrxJ
 cmjX2vrv76JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThAAKCRDa6OEJdZac
 5YA5D/91sB8UD0Blo3tVwJRv9w5ZITog0Eb1LbFWXHuxNDlVHDgDh5g88kaPS9rEYoMFHQ9dQkN
 5U1gRweuXNXH6JNmwdigMPn/2mJh8v6k2k7NPH/f83u7XR1JSG2DUvS6Tz9h8TvDa7iC9KkuBol
 Vs3ikE8Ky3/jhcZ1HlTty4LxNIOQz3r8eWHg4QVuHn4F9DH5gu2tnVHcvC7DGAuMTZbbZzhHIWF
 PaKJY1nh8eDuw97yUOnaPDJFLWbEueuBaVkGmCdmLvexRRJCRf3AVjaL5r+sdFd9qHrw8Q4fzUl
 ZxdxFBJQqAN1zStkteKmetSSa+OnMpiiLZL+QH9xoayId7QuvWXzPqsLjEvy6HTvL6KlVdKsryF
 h6gh2shC1t/dGc13uoViPNhsZRTGfwYXR/Fx1crziei2lXDbbkDV+yb4w9TRGO+vTE+2WknWmCo
 u8EiqvxYn/0aqYOKBTjAv3DXYfF6qV8OEU7Ba7CobRZHCf3zQq7mQ2+hn78t1KVs7wn92zBvLrl
 X7/vGNGiouwQySwiMyyqz2EStxvmrGezIF+DdvvVXo0X8fvSaCx5buXLI+dnyM+bz+muHu2Af4l
 2L4RZ50w1OmoPbvMTj++3OQXUpwVp1hIOJq3kTpBpxP0nRvtRxELe30QLhAec+Ihwb9CNwk+JkR
 R6eWq/2gRkjBICQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

On Wed, 10 Jun 2026 13:34:04 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Convert monitor_accept_input from a oneshot BH (aio_bh_schedule_oneshot)
> to a persistent BH (aio_bh_new + qemu_bh_schedule).  Oneshot BHs cannot
> be cancelled, so monitor_resume() racing with destruction would schedule
> a callback against memory that monitor_qmp_destroy() is about to free.
> A persistent BH can be deleted during destruction, cancelling any
> pending schedule.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


