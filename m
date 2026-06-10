Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B404CD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQGW-0003ql-IM; Wed, 10 Jun 2026 17:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGM-0003et-FK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGL-0006L3-3a
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sabwulMuKZ476XPf4klcAIoBMnPUvHK/X/bp9MqayY=;
 b=WsQAUs3KYv3d0o6p8kxm7aN/JbHo6LLl9GnW/XtTW6H8479FPoRiXdeiH7gStTgqKLbcxo
 0hoFkFm5l+2SoIMOIGdxAgIFcaYOm2EzQZZ33bso4IJ80Ut0wJlf0mljqMz6jRRNs6QKtn
 Yka8zq4prSBsxcGo9ktakRM5aRJJvtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-B62X8qzPOneHgxt3QpCNZg-1; Wed,
 10 Jun 2026 17:14:55 -0400
X-MC-Unique: B62X8qzPOneHgxt3QpCNZg-1
X-Mimecast-MFC-AGG-ID: B62X8qzPOneHgxt3QpCNZg_1781126094
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA711955F06; Wed, 10 Jun 2026 21:14:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3CCB1954B10; Wed, 10 Jun 2026 21:14:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 12/35] monitor: use class methods for
 monitor_qapi_event_emit
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
In-Reply-To: <20260610123415.2883603-13-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-13-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600345.209622.8522825819630494967.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=317;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NA2pAXtzWQR+fZSt1SBkG685fsoTufiifnMiGRfubyA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOAbpYImFkJ+25skMKYWCLSfsYTUSSPtlCl+
 Et+GXNoBCuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgAAKCRDa6OEJdZac
 5WTED/9zrhtVCMKzNk8i7L7VXK6l1LbZFupBS7TRXvCiYf8CWsVoKQ9u/PLqDWAD+SXBJXT09RF
 eBkFkQTnWvfWY3OjCWFZngV+7rkRHs5WR9u38VWMPzJ7CjT8mWpFnEcruqzjAybgWciSwNPyaFh
 kWNppXpdMrraSv1QQ0wleEvNWvVU+ueftrkT4WmEgiYbldNrKG56Meq6iDtFO06kHH77ew3NUD0
 wFg6aMhGI21QmfcLRmBE5V5HihLe3xsLsE+rmK9Iw813IaeAz9d0DETe9KXCOcBX7J+4XaT3eHD
 iSmkEuOQk2BVsDihTW+vo/A9BfzyyFlkiWxTEdzWVu/lAwmacrX2rvZwUj3o74+xDC6YvdqJXST
 zYb8L7jjlYw/S+JKJDRCx32mXU+Cj2HI1VcaIm4F7jAvAVS2kAjyXU/CmZHT+AsJr/SbaUoB74j
 aHNOnSyqJVhq+xsWjcAaS2aZRwgqROYdjburfrMqGDIJZjcS9sX+INZmAKAq0WR5rdMNYV1dnzM
 Rx3X83Bhtd0UUdKkvsWUIZy5g9iTA2r8cKrade8h8tg/OSKbz5+Za2nDt/KEl+4xwSCpzwdLZ3K
 VhWvIBx21kqpnFwqmH6vGa6SCu1iL9aghsiQQJvmrifHH2UiNiYd27twPzrhyhvuT9mqwHHq8AP
 GTJgTz3hc0xdgpw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, 10 Jun 2026 13:33:52 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This removes the need for using monitor_is_qmp() to check the
> subclass type, which is an anti-pattern.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


