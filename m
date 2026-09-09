Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390B5C88E41
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Om8-0003ue-Ip; Wed, 09 Sep 2026 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om7-0003sz-7C
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om5-0006tL-SZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xSTq9iosPvgPsQgohsMLO8d7WMooLbp2DkUMbmeyb8=;
 b=UOjxP5GRgKFEVEGJM6R2DNIHzhxYZdsT1poUvMpCZ+gV3Z+9GpoCGCjCTZF8UEQsuCxosE
 //ug76UBgaVyOlFt9vqQdPEjRyu29V0mXYZ1asWuCP1931w4Qk27Aqsh0WNcu1I8Hde1j6
 CFjFz4gVe/zdCdAJXck0NoEb6UvRkiM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-M3voSqg9M1i6BBf4lpdpRw-1; Wed,
 09 Sep 2026 16:20:01 -0400
X-MC-Unique: M3voSqg9M1i6BBf4lpdpRw-1
X-Mimecast-MFC-AGG-ID: M3voSqg9M1i6BBf4lpdpRw_1788985200
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1471800587; Wed,  9 Sep 2026 20:20:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1A1219560AB; Wed,  9 Sep 2026 20:19:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/14] system: report machine security status in help
 output
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
In-Reply-To: <20260909175656.1572689-8-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-8-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517057.2613908.7480438163663747950.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=289;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZM8OAlYBzVprQb2LyGYauZLM62NuGGxyocNQcn6uhco=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9VifWH6DP1TshJ53DXOMu3/CTIEuZEYMUHb
 VtPa/HUb4SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5cK+D/4vYGJ0Wls+cKzVmmXHfEvH+1tV7Gj0BxPAfolOosjG0XifNoddC4eLX3MnHQ3nytDK9LG
 wfdsTPhEN3h5nszjjoYODW9ssTPtMIMLTsVf5l8CQhMnAyZtDCeeOJl52ngB62JV5liMxDv594r
 frucOoKOUhKXBFErCXcUfySqSuchQdPBZvW0GS+rjCSCsVKkuu1ree+3LULBxi4Id7tYL8OGZgD
 n89ILArKuvtc+ABLjQuT7F6c7ke12rMIr7djwor+Vzyiyd2h18hs+9F9ycs5uAB0KdxQlHvCgVR
 cplW79Fsju8ZJHCQy4hzELiJ6Wrco1K47nBTG6ebHcipzeF6JiCWk6xABaUR1tMxTfY+fgT/KFL
 4Gpv/g0SP5x11EK3aFCND2gHX7wws6/Ck0H5rWRA7fzDMBGgiARgAymTzyeFOdft0iuaJu/5WYX
 yQCa+5KB8IIVi8aFvZqFz7eqsJhkynJ8o3aXPhNjn9MKQthjIXrns9obnP0jKaYUCoCjGPPUIin
 ue6OFVU7Hr/eMu+0jjtQWhpj4EMfhX+StyQg39gHDSux3HVRX1GU55peD7xwBVE0gzAXYf9FeI6
 +57j9X0Vtqf0duomPxUC2RLrJdAC3ANDiJV0yqpwhl6sljE78lcdmQb+Fmqc6I1g3OVUcRrqxfs
 c0o3CPyOVbQP8Wg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 09 Sep 2026 18:56:49 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> When '-machine help' is given, report the security status of each
> machine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


