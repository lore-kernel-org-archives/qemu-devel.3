Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B6C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pgE-0001ms-So; Wed, 16 Sep 2026 09:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pfz-0001l3-1P
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pfw-0003tJ-2V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cfAAcEhAjcgTSOW7aheuAhtFv0hk1+IZ6ErzEjcuCGs=;
 b=GN1a4lq+VXcLc8KTlEpTtPi2ik3yI9ibTmLI9aAn3G73zU5hBMbVPdnjKmWXB/Wd2yXtb6
 JBJeJl72UzIPVacVU7q97iK+XOMJZw7Bdf8evRWt/pzJh4zBD5oJeuCNWV1eKexSG6zTBd
 i64IDbpFmzRFMtQk4Yp91t/TvU7xz4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-slqVhLd6NHas6KS1y5aBnw-1; Wed, 16 Sep 2026 09:27:45 -0400
X-MC-Unique: slqVhLd6NHas6KS1y5aBnw-1
X-Mimecast-MFC-AGG-ID: slqVhLd6NHas6KS1y5aBnw_1789565264
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so32755745e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565264; x=1790170064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfAAcEhAjcgTSOW7aheuAhtFv0hk1+IZ6ErzEjcuCGs=;
 b=ZMUVx7su/91V7EG9F3qHlooKSnMCO61xwjvqkACuCLOHe+qsavGqufjMe57tGZmvNb
 IHXKwvF8ZotV9mQpFvS2XZ/XJMpC/2f8pfHQ6QxrV7LAvYd9frtK93trarJ193ajZJB1
 GpbF52xOswSUYJcUucpwBAMJayQ/dSNcNnNjra7+jbBDj7ZLsbBI4rE+Nj7glw1Gl72J
 Gn7IMEds17+NrpTRsjNw6PN9EZjBquxyf+qmzg9yCLsQQ5FMSVpmpU9ZSV6cCkwdlWb1
 h/gi8gwQBkUaZQLOA//FqRg36glUqxF8HTTv5SuzJzoyIDRMJ0RDf6ysbPttj1ILwlJf
 cvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565264; x=1790170064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfAAcEhAjcgTSOW7aheuAhtFv0hk1+IZ6ErzEjcuCGs=;
 b=YB7UaW0NR6RtYuOCmiCnlZh6Y4jirTxsiCzs29dgbmMj+Q4MzHI81GzSDtUzbFR01H
 /wW5Ke2yHQbVUY+xItAxGn1956EaL2luDnPw3WVo0D/EFFTYgIi5PITUJw6JWTTEd2aP
 Ni61vu9vqCygC5kt026mj2YaRXGRjeQIZBp1DX0IxzBnWljqseZDFSKIHOK5dcvHXsFL
 OqXPsVww6Z5JSHtMmi+07KCIA7589yHaA8peq2y1Vg5MC05hTAAJS+VSB9eiR5toCwvi
 CsdMmuM+gIJRMFS3/Yod0Qb70h8Xa6D8eOQCI+LQi716VigUfIEeR5jDCDQTGyLDgDWQ
 +Ojg==
X-Gm-Message-State: AFuF++nyxhiFWO0dCx85Ru73XcF6qic2CCsoonbqkPUB5FCOqbHrDx//
 UpUJ2SkcV+uPxnNbTWsdKmeUD/o/C+ok7ZiQGD5lZF4u9VXb2Qx4ZgCdK/hKqrAvyB5e6R56cWZ
 M1VgPxYI1q/GVEotDx12VVoIZEUcfXz0NcIiLYgPh7zo7QO3L6yc54ftUO+YQsjgRIHAZCD/PWG
 EGhAj16+Hkq1MQUrB6xZNZQc46/4BBdgKqPQyYfPWi
X-Gm-Gg: AYBFou1RjHqiyVI04l/fz5Ry8QPgLERImEy1Qco6iHvmcQbSrYThVFlcVhttfAVThjz
 PBYxJjd9Bax+Z2xDVuYSnJ2MELodToHwLoZodAYCyEQRvGAxAyVNlZIa3DhlhjxEGlo7FdC6wWz
 fXVm1xBlD+KpLy9+f4vKXC6bItjbBkssF7Qo19iENGvzdhPBkOdAI1Uzc3YXgoQ3aZUUekceYQq
 vfTGEE5YZPaxMmXAPaq3iWNyf9FWjBmdfqtN/wDTYRvRe6oYFfW+24GMJEtE397gMf/5IpbKeel
 DCDU1TwNbNgBTrF1YE/OuIllLuUn5/LKJ1AOK+gvO9ZYxFXVjfpR/vyoGRSVwVF01V9my0e1U9C
 Wwcd2lJcw1mk+yUCnJttpVRlRO3r9sfMszAwIOuRboZd7rbp2E5WiBP37Mla+ZHJWOaOLgb06gX
 y/YFmf
X-Received: by 2002:a05:600d:8485:10b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fbc43a0a0mr6428575e9.8.1789565263980; 
 Wed, 16 Sep 2026 06:27:43 -0700 (PDT)
X-Received: by 2002:a05:600d:8485:10b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fbc43a0a0mr6428085e9.8.1789565263375; 
 Wed, 16 Sep 2026 06:27:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27df9sm6892837f8f.19.2026.09.16.06.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:27:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
	qemu-block@nongnu.org
Subject: [PATCH 0/2] nbd: two small locking patches
Date: Wed, 16 Sep 2026 15:27:38 +0200
Message-ID: <20260916132740.872244-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Two patches from 2022 (!), rediscovered now that Denis reinvented another
patch I had written but never tested (now commit cd3be3bd96c, "block/nbd:
clear reply.cookie under receive_mutex", 2026-09-02).

The first is just documentation, the second is an (at least theoretical)
race condition on s->reconnect_delay_timer.

Paolo Bonzini (2):
  nbd: comment on locking for requests[].coroutine
  nbd: call reconnect_delay_timer_del with requests_lock taken

 block/nbd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.55.0


