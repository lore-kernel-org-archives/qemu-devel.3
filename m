Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9261C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0dc-0006Vv-RT; Mon, 17 Aug 2026 12:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0dU-0006VH-OO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0dR-0003C8-Fu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786985787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZ0eHDeCXsIfjtnlyMoblc0/bwWiPVmyGURcvI0RiaA=;
 b=hXqnhtimCBSXEEnd+SWRX/2JZh+5vUR7nrAuff7ksvMFsv3sd9hOE9YiAVcnq35DoJzake
 Ip/vWYzF3qPGq+4Qna5iTALucXSAJxTFhIKQOw/ibiqVxxi33VbrAEt69svi4PY1PKrOaf
 KLKeuQx33xv7tjIKKgLsKcqgTBOmZKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-tlYP6z_fMm6XR5ce5nQ1tg-1; Mon,
 17 Aug 2026 12:56:24 -0400
X-MC-Unique: tlYP6z_fMm6XR5ce5nQ1tg-1
X-Mimecast-MFC-AGG-ID: tlYP6z_fMm6XR5ce5nQ1tg_1786985783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E92318007E9; Mon, 17 Aug 2026 16:56:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24623180034F; Mon, 17 Aug 2026 16:56:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] meson: make linker warnings non-fatal on Linux
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, alex.bennee@linaro.org, 
 qemu-stable@nongnu.org
In-Reply-To: <20260817134313.922754-2-pbonzini@redhat.com>
References: <20260817134313.922754-1-pbonzini@redhat.com>
 <20260817134313.922754-2-pbonzini@redhat.com>
Date: Mon, 17 Aug 2026 20:56:16 +0400
Message-Id: <178698577645.3397024.10682120600462467104.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=314;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gVNHzbNGrZhSK/xUIHzT8JhrDF4G5Dd4Orv2xwsNMeE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgz0yzUiijdPaVarcX5mh32QqvJ3cEwsDM+aki
 H+akVeTbECJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoM9MgAKCRDa6OEJdZac
 5e8RD/9AWPSxZOA3uWn10DJZWraYB9vbREKO9fxxVa2gCpj5MjWUaqtEKaWRSpsRJJ4fNKXc3Zx
 K4WxYk/pA5D0h/gn0RXunNVCAxtRN8905cOzJpsurbC4wy5J3JZn6Kx6L+LoT/RQONV8oKy34IF
 bFEId56Gghyxdx3jSWpjrQb8MSsC7dbvpMKmVgji1luIyTg6Ih7n8HbNDmYEMaz8pZmafIP7+S9
 VjK9hq61T6k+CeguV5jdyzYEEChA29HX76L24OtNEouawimpV7bsd1IDXhAcc+r3Qc1mogZ0gSf
 vNJDOHSks5aJvSQubC+sek00odFE76it3pQTvDKzHBwhnhPX71HfBiPa8Y1FycNTJweLNpfTz6R
 IWNAklF02o1Gfv6QNUhnDQ8LDnZuNGPzQh6vaJ2nDTiK5Dq1so7xA3A70CxeC9JmiKZGwh90BDD
 JxZ8C08beplCy7bfcUATK4WUqaUZYrfwCmUbV4BVyw1H/CHzKCPEJ4sFlVY2GA6DAyBYzo+vpNd
 U2fR5qKkcgYKn0oDpdBfJlW5pwe606dSCCvplUt5fsdyTjNhoUs35js0Ot8wJdm7ihgXNOO2zjT
 bYMhxqJPsDzrRUAdzYFOLGWSXO8bBELK9WKfVYVssVuJ7snfh6IEPoIOiTp2SY+cys1C1wavTwE
 6F0yw9M+MyhvxVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 17 Aug 2026 15:43:11 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> These cause a werror=true build to fail with Meson 1.12.0, as it now
> makes linker warnings fatal as well.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


