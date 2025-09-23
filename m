Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5450CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0y5J-0006uO-FG; Tue, 23 Sep 2025 04:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0y5G-0006ta-DO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0y5A-0007pE-Hi
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758614941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KjrYIxYkTzNnXWH4QXzhA0r7Aoa2jAreU4nvfoqSJ+CisgaSf/L7ayjLmFHUld+O+oZjv5
 v8q61Cl+AjArBPnAzvzZbstrS0MS0JHVW0q2LHgmTVqvu/Mms1W3ZMyAXaTeeOp3fKWBUZ
 jM1L397NmW2R2MBPGmCxEbLsoXdS3pw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-zNLh1fhFPbiQa66zAswZNg-1; Tue, 23 Sep 2025 04:08:59 -0400
X-MC-Unique: zNLh1fhFPbiQa66zAswZNg-1
X-Mimecast-MFC-AGG-ID: zNLh1fhFPbiQa66zAswZNg_1758614939
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afe6216085aso486826866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758614938; x=1759219738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qz+LN7ZMWBYgyiCpiBCHW6Uud2ZHLS6AHnwc4F7R16jYU2OQVcoHHgCeWDRzyLiijt
 sOBq78IszhPlcNRj85bNOTTlOL8L5/Fv+9RMCz2zaLJp3kM0+wTGhRb5ZbPrb221BI5E
 uPtbUEjN88ypdM55bOxivAkTk/j1E2Bx6wDBxldJrzGIrYjyK8DsBaYIhQKYegPsaZ9G
 1TTLutq5qScu2LN44UFfH997StEJzJVKlRpCtZAbG9dvmCrklR2pUjRmof5WVS5w9vbh
 P2Yxp70gfwYbYba6vWz/jF0YjBXRCI9RncarW/+aS4dO/ja/LpXWp9M1cw1R2RQIWKaB
 NMyg==
X-Gm-Message-State: AOJu0YygYgEiKqip6Qw04LV28tNR1PcAFRNaKFnjdKsRHEb5ghhfG3QS
 bjZmwHT39WzeNMhSsvoLno0MIRDEW+yVJtZzLGzCPA0AieiNnnudXtzPp63dJBXWi8sZvCPy0lX
 aHIID8ciDtYuh2jg+BXdw7KuSW0avC0HzlU1+epTLnwhDdrAG52F4wdlT
X-Gm-Gg: ASbGncuQpKlyLhiLoWYGtgheteC8WdeuWQv3lFFGa9jY62+6Y6YXdStkXMdBnIwXyjl
 AR4H2Oe2Vd8TGeH3YABf/hY3JQgDV9+bP6pY6ZlnS6oDyXG66Tb0LVo3WUya0tHOFdCSx9gsXeW
 8jey9eN4YNzVN0Bw7z7Syc+FXtD6pgi+bfzjoda0IXTC/dHNi3/RBzljSUSTomjOFIVE1M1Ha8K
 zGelud7wGGikxFceUw7SsSAOXQOLe5UxJdXoWc9s11JYata0xMlGn2X1g2l/eOfdmXVNlFElg0w
 AEqxrySJaldWkRD2DagiSC2ZIPdI3bWM5NCw5o/B+fB0w0eWrhPkocqgdArSvfepA2XWxjpQoMx
 0W8/8PAobsZVZtKdCXXqbv6GSOQxj25ek37lyL9P3q2wCZg==
X-Received: by 2002:a05:6402:5041:b0:633:9e:4036 with SMTP id
 4fb4d7f45d1cf-6346778e1b9mr1374778a12.11.1758614938538; 
 Tue, 23 Sep 2025 01:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfEVzMzlegsS8RRRWXf5AuMiTyV3RuuZ4ChXwgv3Yn5mo7kYPCIJoERh+giB7/42ECgMCO6g==
X-Received: by 2002:a05:6402:5041:b0:633:9e:4036 with SMTP id
 4fb4d7f45d1cf-6346778e1b9mr1374717a12.11.1758614938103; 
 Tue, 23 Sep 2025 01:08:58 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-633148d2df3sm4465772a12.30.2025.09.23.01.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 01:08:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/7] Do not unparent in instance_finalize()
Date: Tue, 23 Sep 2025 10:08:53 +0200
Message-ID: <20250923080853.94322-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


