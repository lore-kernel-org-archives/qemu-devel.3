Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA91CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01v-0002OM-2k; Sat, 17 Oct 2026 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01Z-00024y-VG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01Y-0007D1-Jn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQRrtNUp/COCkyT/S0/Lf0ib6YVTzGi86Na95jRKHco=;
 b=d75Em9e8++FvWB5yfn1V96AjKOZ0tMHKt1qVcGgMDI7IS4eFD1NX2QK4VGNjLPfdenbhbZ
 Zn4z8o8wMevUFxMbuHHXXtufI0vZOjuilcEOk6zZh/dZ5cj0fzeAyrwhml72KK0meemPNS
 mif2e4ypDSQvOwCyOmyjKw+V4vdvDbg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-_Pzlv3WsO2CWrJSPKnNvTA-1; Sat,
 17 Oct 2026 08:44:10 +0000
X-MC-Unique: _Pzlv3WsO2CWrJSPKnNvTA-1
X-Mimecast-MFC-AGG-ID: _Pzlv3WsO2CWrJSPKnNvTA_1792226649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4382C1955E82; Sat, 17 Oct 2026 08:44:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49A491956089; Sat, 17 Oct 2026 08:44:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 21/23] target/loongarch: implement get_note_size
 sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-22-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-22-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656911.1619676.1843951032763605797.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mDR1RlqTN74bPfsvUxyiYzIhOiD4Rh2v6cbV2ZeIESY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUN3Ko+nJHzQM1cylb+q2zKoEOEpYDflCySx
 4BtVE7GgTKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5THqEACLYxMXWByF3H1nqksAcp3b/y3tC75SiL+j5JEORaoQurkAGb10LyH9Ihw+qrWIcxLfHmS
 LHG16erWRPePrVIN7m+jwDH6vrCwZi/RWaOrWXEDjtChFhKzazd+QxpdV/9ASPsLa1rAnbhgYGe
 Jop37gxykERrF6ae1rSSMoopL1t4g+jmwx0TLTkIBtRtnXS7j5DufASO6qUfhuQfhVcjFpKQbHx
 tbWU73/vhX6bTtLgg2DPPKoUtGLqOCOENYhnU4HWR9Hs9mkfA7gDFlkcyZsHfXG+YWez6tP+UhL
 7bgmfNsPJSrdmhizz5tNv8jArNVRTbRtO3LHA2cGYKbUQFkb3c3GcXztsP9iocE0NteBGusTa1y
 9+WMK9mdlxixEfuZbKRFszsskf3E3ETS/an1vWHSg9uBPkYdvLDPmwz3Y8hx8rehh6c6lBzyHeB
 LX+0ja6P+XJr6UiRQtcs22fAa84ezdvVF4wr/QAeYyBslqXwtaNMewzpSV333VVicO5oFbdU+9e
 eAIdgN1Un346NvR4fMh7WLznZO0h+FD40C+fVMZP/LS0y0U54sZtSnQpQTbiZ3Cl4EXs2j4epAs
 NEsXlyjjmxCiXU0m8JFYNG7eBLWvzpAIUETGfc2+sHZc38gH0rLAajjHdzyGAtDBcNBLtoBjRDh
 nYVfK8SS/lWCXeA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Fri, 16 Oct 2026 11:14:08 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


