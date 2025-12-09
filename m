Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACE2D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bb-0007EF-Sj; Tue, 09 Dec 2025 11:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aW-0006I0-89
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aT-00020w-RN
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GT8ILsN7D1OcqOm+bKXlh0KokTwS1VY6k4jMj1L4fKc=;
 b=e20N9QoLw7iFgtgR98g9u4x7GiZu9qBb0U8HlGf7ZdFwNP6+Fr7REbI4+abPPNkkLp3gQw
 rDa+JFDOaOrIkoWAKGnB7hHAN30anC1xQ3ahdaw9HG/XgprtiZBJyYJnOEUfoEE9/WOIe9
 NLDzGR9tY8GxAlRHP+AhjzadhkiFtnI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-b9agDbH3OhqElkI9dFNwtQ-1; Tue, 09 Dec 2025 11:29:12 -0500
X-MC-Unique: b9agDbH3OhqElkI9dFNwtQ-1
X-Mimecast-MFC-AGG-ID: b9agDbH3OhqElkI9dFNwtQ_1765297752
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-880441e0f93so162772586d6.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297752; x=1765902552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GT8ILsN7D1OcqOm+bKXlh0KokTwS1VY6k4jMj1L4fKc=;
 b=EzMqqCRjUbc+3iC8mIg248XOsVKRave7l6yChHGKrFP5ByCdHrNBrQSkHQhV8zwjzX
 HlLzDHiYuTovulDDt3oOs8zCB+jhhJ6vDmGLk/xa5oPJq45yMCxD0m9rYXoPwDnV8AyK
 Ixz5N2hcP7ipb0m4B67NR+ukaV3OgJVYyKmkAejjMJl4c7N5UQlCL25Rik5wDkfrCC51
 Jt6dLhMwQKYGMpRisGz4uZW5b7SxB7i62tilmsEmnt1Q3blegwT52TAeUvasA8JF+3eT
 0XWh//DZsj57DMhqaJQAtdEqY53CwsaHdwR5OG3x8DlOS+Aze1tPvrMdMpw4XUqwulW3
 TUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297752; x=1765902552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GT8ILsN7D1OcqOm+bKXlh0KokTwS1VY6k4jMj1L4fKc=;
 b=aHTzSBsf8fNHyaBmsb5erWLuQxJVmsjf6TxnD3Qsv7tiXRe2XuIPS5fQb7pXP81ffB
 ufg8In9PYoImz1x+7S925txexKuj2xL8sItpZp67//noY5GBGqS5MXhHAhi3oW75zDpm
 hKrLfpPku7GzefmxSfMN4EWd7GBsO7vUAtIsZWRxCu7Rguuy+wfXg2RlTyarnDkmHU4a
 uncr5PeTwrKydC0A4+1LsRPqCF2MwVgD67PCY887rqd4fu7L2GvARvqXGFukhRH3rlHp
 AnycRp+48Lcvd9swm0CsQ40uiVOzBZKtbVebZZBSXQlMuqxhK1Owxc4Fb/ZbTOqXXgzs
 Vh0g==
X-Gm-Message-State: AOJu0YwhuSoRsPu84SAjDnNiDFxMxu8QxKwnM0CrKToq/szH5m3Kn6mm
 6wngybgVHnaQEJ7uyBFJhiCdaBulm6f0XuDB+BWMsQOR4Z5F0jYPFi9HVxCrBqXm54Yep/yT1aQ
 h+Szncl1c/Chx+7e3rqtIFr8VnAqP7zZgQk/5DQI1qY6z8a9BjfX++rFy0ICQJ5EVgmSOcRZMvQ
 +iURB5F7MntqqZ9Uz3Wopi1Rz6jPMY6ZgvE7NgdA==
X-Gm-Gg: AY/fxX6FZU1F7krii1m3YVMGkcLOuyovof+ocrLyTF4mPUCOPzte+nPJaTB+0dGUzsg
 RaKDRQW4/ClNH97CVffMb4kVZk4KFYkwA2K1woVurDrM3Bcza0+ycjmXb7pGnfA8DQ0/nMVbqeT
 z5vvAp5frW13ftHamvp/AVaiv+sngoaSXfCWNsmh0P3StjUtq6ewLWvhphzL30+T1Hp5DuLNqCR
 KREBR2QfRZZqjnlY0+2KMsaJYLlJoVV93d9nkZ71EzzpxP02yIa5E2j+w81Bpa0XJSxAm8qTLp2
 eJzrqYugTqmUiyO8qDw8TUFcQwIrlHLp3lTEdu69aXa1nWzu5OKwOVhTqqfR0PVmTTqkAu/04xi
 A5Hg=
X-Received: by 2002:ad4:5d67:0:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-8885c6f8c7bmr28438996d6.21.1765297751766; 
 Tue, 09 Dec 2025 08:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu4RgggDwK66ekvZpozBlw/LJU0gDvU2FVgPkg09ynmspyG6vpFqoxzEz0CUnC/vE/TcPYTA==
X-Received: by 2002:ad4:5d67:0:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-8885c6f8c7bmr28438276d6.21.1765297751260; 
 Tue, 09 Dec 2025 08:29:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 06/10] qom: Unexport object_apply_compat_props()
Date: Tue,  9 Dec 2025 11:28:53 -0500
Message-ID: <20251209162857.857593-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now all users switched to TYPE_OBJECT_COMPAT, we do not need to export this
function anymore.  Instead, future objects should inherit from
TYPE_OBJECT_COMPAT when compat properties are needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 1 -
 qom/object.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e5b3116ad5..6c7b8fdab1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -707,7 +707,6 @@ void object_set_machine_compat_props(GPtrArray *compat_props);
 void object_set_accelerator_compat_props(GPtrArray *compat_props);
 void object_register_sugar_prop(const char *driver, const char *prop,
                                 const char *value, bool optional);
-void object_apply_compat_props(Object *obj);
 
 /**
  * object_set_props:
diff --git a/qom/object.c b/qom/object.c
index 581c041b08..176b859f36 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -530,7 +530,7 @@ void object_set_accelerator_compat_props(GPtrArray *compat_props)
     object_compat_props[0] = compat_props;
 }
 
-void object_apply_compat_props(Object *obj)
+static void object_apply_compat_props(Object *obj)
 {
     int i;
 
-- 
2.50.1


