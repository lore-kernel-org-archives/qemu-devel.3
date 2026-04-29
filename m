Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F3FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICe3-0007a6-MI; Wed, 29 Apr 2026 17:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wICe0-0007Zt-TW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wICdy-0001bF-5G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777498828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qos86uBtUBviycmBtdvJkWQMQqMeRaX/QKHrhUIoWE4=;
 b=W2uYxtSIb6Mtu3UDr6kc0JnP+MfU86SjKvW1eet8V6FsCgpzO0pr+0HjdplPL22Uw9XNim
 SRTzKIXhNAqDf+UR0L8qi/EDs+vZAl0yRzrcF0upgm4rF0S2+Nq3DCkpeI68uoXwYrNnTk
 i27CjJ/kVGJ5nx+Q/KHAilyosPg0vDE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-Pm_jtTCDP76SPm-yhUAdew-1; Wed,
 29 Apr 2026 17:40:27 -0400
X-MC-Unique: Pm_jtTCDP76SPm-yhUAdew-1
X-Mimecast-MFC-AGG-ID: Pm_jtTCDP76SPm-yhUAdew_1777498826
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2E6E195608E
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:40:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67CFC1800480; Wed, 29 Apr 2026 21:40:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/9] qom: add trace events for object/property
 lifecycle
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260429210830.594724-2-berrange@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-2-berrange@redhat.com>
Date: Thu, 30 Apr 2026 01:40:15 +0400
Message-Id: <177749881568.809163.3651828558097466353.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=590;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cBADsH6MCZqZ1SxcXD5jjpKnUkAIhdw6Xg2JUYnQiIY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nrECFq7HQTixjLh/rDiGGPn9DCiHF2U+/+vf
 wBtgWCq1r6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJ6xAAKCRDa6OEJdZac
 5Uj/D/9gSxI9+yUe69DIeA0218YPndXROP3XrnALsdoYJTCokBZP/N2W3KsXdB5+TAkSZ5Sok1L
 l/xWSEYf96W90JTujHksJrHbKuhOvcWupUwLnEqz3aRcSzLDPgYouiUpvWuxlk5iu3hQvGecXti
 6/5af3/lUUS5sJfl80C2uHA2JKgN6Oc6FU2cE8Fw36bcGQpIUd/5CgY6FXVT/0S0p+rPBWbE9N6
 mRWSNxLqHsG55UFKM++25jIyHDAyr0XreroabPr1m4yndiuSs9LF3pEG53f1cuo/11zUNPlmA2Y
 9Yhw/Owsm9vGskMPAgllLXoehMnthUHeRmuzqDCmyRAoLl/f9z2DPa2X9PIA3xu7JJtt/YB/IzY
 ZLK+6T4Pgfsuv2ulGUA3qb1h1pkniSekzqmgkFrb8mXypEyJt7Hnmm8Gy2dHzyxkEF1P6WKVXD6
 N9SfKZHZjEY6+YfBs10jmPzXcOWa59zf68afvhwfC/6HVbmYLUypshgvngtLGMWL2iiD2QBmQbi
 hE+CfDEYz5nOY6v+h3ygMU82rHU03KF0uNylbn/32BBEVB9arDuo7Y3tDD6Df2NAD7+k/00of7N
 4nhBKv+VfTkPr7BbIQZ7yz3RWQpCFPHJvTG7JEwkOfSnJZTD81KOoLJ0wLMI0Q1vb8qCzIqfra0
 xD920/931CxyqTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 29 Apr 2026 22:08:22 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/qom/object.c b/qom/object.c
> index f981e270440..b99da7309db 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -714,6 +720,7 @@ static Object *object_new_with_type(Type type)
>      object_initialize_with_type(obj, size, type);
>      obj->free = obj_free;
>  
> +    trace_object_new(obj, obj ? obj->class->type->name : "(null)");

It looks like there should be an assert(obj != NULL) after qemu_memalign() instead.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


