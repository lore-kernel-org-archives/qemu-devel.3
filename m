Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A07C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Ols-0003l4-7k; Wed, 09 Sep 2026 16:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Oll-0003ki-Tz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Olj-0006pE-IL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EG0XMKKXkoV3ryYGWylhRA5ZUvZIH7+D6puLA3Y941E=;
 b=MgAlg/BGf6b/2CNqO/wzG9AfVO/EHQluiYSZjfcbSiN3GzxIntkup1eJfouQ41BEEBgBh+
 dfrT45qoBoGQ9wOPlrHKde2CkV63zLgpS+3dFH8GCTcyispE8i9EHbEwncwSbcZLUsgnQz
 OWsY3Km3oySYvUdLpMazyMFAgHsd85A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-aTWQst2_NhO4AXjV_M0xVg-1; Wed,
 09 Sep 2026 16:19:39 -0400
X-MC-Unique: aTWQst2_NhO4AXjV_M0xVg-1
X-Mimecast-MFC-AGG-ID: aTWQst2_NhO4AXjV_M0xVg_1788985178
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C9A019560AA; Wed,  9 Sep 2026 20:19:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E262019560AB; Wed,  9 Sep 2026 20:19:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/14] qom: add tracking of security state of object types
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
In-Reply-To: <20260909175656.1572689-2-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-2-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517053.2613908.3319661540580692968.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=515;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Muu57Ri6IKwqOTgPkv2tz+TBOFlfHNiWHHi6/oW6mnc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9VER+gelOgbqEJhEinl1xrXiTKqUJI3BClU
 ECwlxWiamqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5fzYD/9po8aiGGuBnLUFWIDWMH6lQaV9oRT6i10o0A4eDZcFhKsnmMNrwd93+Sd9whwiUyf5Iiz
 4WHoXEMsPGtnzTkdNgtAmKNxj3N8pYYOGTovP2cyxnfQzEisPGUBatN6I9H9KY+YHS4vfk8zxiC
 buLt2vCQqkP+bpgQgQt3fi41fMMdAx80XyV5Pj2Fel4EnRFuJPsIMq0Wsr4slJCRvm+b9bqCjbE
 UlLkmawl5EnFVGPd8uH+ZS7HHHKg3ttF+YVZCUikuWxHQdHbgwIpE/ZIMY4nbsRGBlnAWP7D9G0
 AcEO7y2uMEpqz2n3B9kpjwjsBqLnFgwu4LJOJHJrOUVRst7a+6I3huK5caCk82p8GZtAGqU0EGv
 WqMMrHXup4VGlb4FwKlMwsYFaJEScZtgYTRT7osJrYEy3PDsmmreZsgOSZ5UdC2zUmyN8edRpyZ
 iGgB/6I1lBXpq1pw6pAXjU00T2uIhSxIoW0d7m3Xeu+7DY3RI8d2PiBbGZkcsIO9RioQTHWMeex
 GWNRZrL7VNOgLsh1GySHcQJ7+GO/8Xe3bs9RGVodE3UZCydbsz8Son7Gw7oPYnxixUNcRsoIHiO
 KbHnjzJmyhXWDCrhPVj3+xBT3yf3CfvAI/FltLsH6xfMCeFQv5+1RyaSZY0AB8gTNpFcnYJkIDw
 U5L7Aq38G/wRkeQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 09 Sep 2026 18:56:43 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This introduces a new flag "secure" against the Type/TypeInfo
> structs, and helpers to check this against the ObjectClass
> struct.
> 
> If an object is considered to provide a security boundary to
> protect against untrusted code, the "secure" flag must be
> explicitly set to true.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


