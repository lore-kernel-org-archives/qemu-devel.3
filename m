Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63BFC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmM-00048d-Nm; Wed, 09 Sep 2026 16:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmL-00048I-G6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmK-0006x2-3V
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kVjQYqzgyCMQ8b6YJ+yO8Rzx7fltDKpHwOwgvl3QNI=;
 b=Fz58dSF4stgj0n4ECdmzSoSrGaxc1s5dQWEi8fYRXfxxcfQv3+zcsZr+xU1YR4b+Wp59ED
 +cPUps3WEvEjkSHNVe/osILlERsRl8N17qqnzAh3Kk7MBTwwt6DxfkM2POetcgcycpyWTX
 Fq7v/d2M/1oufGJeFAMbHx+LdT3DHkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-pOng0hIaNc6IsafthNlVvw-1; Wed,
 09 Sep 2026 16:20:16 -0400
X-MC-Unique: pOng0hIaNc6IsafthNlVvw-1
X-Mimecast-MFC-AGG-ID: pOng0hIaNc6IsafthNlVvw_1788985215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05439195607A; Wed,  9 Sep 2026 20:20:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 346201800576; Wed,  9 Sep 2026 20:20:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 11/14] qom: refactor data passing for QOM list
 filtering
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
In-Reply-To: <20260909175656.1572689-12-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-12-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517059.2613908.11010402439681570056.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=464;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K7i528k/qBwb1DoNSAWHPegLF83hcoInNrnBiEhGCL8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9W4DpOhcdB5hSh4wSvJJV+fnqrRaCYF0DsV
 OQL5mUZReqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5WerD/0Tu/6PWpybODE0ZDVNgWslRk5PWFK0QXFHml2uiRU1HFZayXvV2h1qou+oMHo7v3T12ta
 OnHEAo30MwlVENR7lR8YjAtj+8iejMVXTbM5zDdkkwhodcAc/Rw+Tf2JnxArxx90oueUmMCMFjL
 n0OLr6GyoOkC7UoERx19eEaBRdubaqbvXFHXWYMZfI1eriw3War0fBcZxQsLL2WfZQTlDFYtpGd
 FKM2JSMF7R9Kmo27iGiIAb00ES5UqZ9rTADI/Y5mGpJ7P6t8Vlh8MuAJYiIi8fMcg5HQvlnEEwd
 dJk/mdRwYbf9NWrNZC3cxv0brgoASDYKku7g1EU387Y2dRXehIrr48dAP7Hh7nhiObrRQfy3Hnc
 S3Lozt3ZVUvJ9QO2+L+85uVyYlGc8DmhihLJS6b7Ny1PqfCNtXunO6Ey4IRAnxLC0aKvXY0MlvP
 xmQ/DW8ZPkargbxEUOFXcP2/C4z/4siUpXhypsyrurH6Q2Owybpj4NLZ4NWgfxg2pDw/E6PFVYg
 clHKWJhW+CO06jZMRca38rtu7pI7iql5DmjSfuEeKvEZ53IFfzJvsDg/y1JABuSUJYNXWmn7jN9
 KP0uKBimQIEg9oPxlsdegTi1f/1eHDFi2h0pu4NObO17kv7yamzR8PN9AOicQnTF/fMUDf0Cz/4
 klCtOINERE77//Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, 09 Sep 2026 18:56:53 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Currently the QOM list method can filter on the abstract flag,
> but extending the filtering to more variables requires a way
> to pass in extra data items. This requires a refactoring of the
> iterator to take a full struct as its opaque data item.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


