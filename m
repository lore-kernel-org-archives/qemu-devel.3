Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F362C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dU-0002BG-U4; Sun, 06 Sep 2026 04:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dT-0002B2-Tt
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dR-0000jf-JH
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=smGZ3ZAQ/JpjeSt/eEgVOx+5vtwkcPyTuz6E6D+SaqY=;
 b=Y6YonU46PpIlOrfNt5oOcXCDjRF74uBgnOOq0DtF6cAhhAJlLUd+xrgN2iatXUJ5FLNTbH
 BmOFc5SlRwc/QN96bT6E99GbIQDVyTTgRJpVBSkJB4vmP6+/aj1q36hmOHDr8gvbwEpdHz
 P+tW7Ym8gbVfWSvlORmhYrNWBIxUol0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-57Ijy12FO--QZ95M6Ymgfg-1; Sun,
 06 Sep 2026 04:53:52 -0400
X-MC-Unique: 57Ijy12FO--QZ95M6Ymgfg-1
X-Mimecast-MFC-AGG-ID: 57Ijy12FO--QZ95M6Ymgfg_1788684830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1291119541BD; Sun,  6 Sep 2026 08:53:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBCEB180049F; Sun,  6 Sep 2026 08:53:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/9] Various ASAN & tests fixes
Date: Sun, 06 Sep 2026 12:53:32 +0400
Message-Id: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avIrBNGF0VdJVqUjTlBFloRhHfPa
 vkW/98QKTBFaMQNgU6OvPoMVQgwrvcTSR6zQaMuscZS+tUtm/R07bKq1IC6NgathhxsgSxf36z
 tfsdjmMns7wFSegDlq7vybgAAAA==
X-Change-ID: 20260906-nohmp-next-771b029cc0f2
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VzRRCytbT5/V3Kw+tgrUBk+fVgtBuwOkncMfdO34t+E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoY2RtFbqlpchb+yIRzVBq0ZoQWDi1HwadSW
 8y/BkpF++mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5dDhEACMyb5Iv4d/Lf5HNIYaO2/ongMxKwU9DtoDR8He4vyx+dyyOtWq5igs0gO4t6TWVn7N3qS
 N+kaPM0RVO9UjQU1ehjtcoc2RN3QG96B4O5gwOY9vsGH2VusYm18SR4XdpjxsM1UHqVH2nBVmNj
 8vfspX9jl/45PN1uxQqUV6tkhzQgUK3F3fbdGW/xtfCv+3Wj9M/xEALqV8snCW2DvL1Oj1EsEtu
 YvPpM2/+iNsZiMgz9w5nsoSC7qPPyz7parU6znDAnyWpGu9dcI4Lq8D5FzVpAozCzsWWuzn5Kxz
 LO7VZp2pVJGR/j2nw7Puf0OfcFIzfFDq9SB1Hs4RJT4oHa1ofx1XAr8XCbnFWyf241miV5eFTvS
 00dzXQY/ESQM0TeelaTaAvNMizz0b9qkMtqQyL1LjzNbSzWqb9j9NVBIcJHVrC+dosLpzeqkCAe
 tq6VKtsawDa013M7Vec33CrLSl6GttVwggr69/sfc9qJhrAQhYN1zrZl5o6Me/mcAUYuZv6UJQQ
 B5G9MXH+eQcT8kcChp6oXT4xIcT5/GSxS2lshLhNwCp0nXT2mIlbTIzR6/MIkRPFtUM20QgsMCJ
 PDFuaihXaJ+LdUyu1rCu1VFO9d4+I8fmGePK1c4DB2kDFDeoVs4vS2hd/N+KLCtAFaBCLPYZIbo
 5DdvqxJCE4N9hBA==
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

Hi,

Along with Fabiano
fixes (https://patchew.org/QEMU/20260903220523.2849019-1-farosas@suse.de/)
This clears the asan-enabled tests of reports in my build configurations.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (9):
      tests: fix qemu:func-hexagon-linters
      tests/test_vhost_user_bridge: skip when running ASAN
      hw/misc/bcm2835_powermgt: free wdog timer on finalize
      tests/launchupdate-test: correct g_auto usage
      tests/launchupdate-test: correctly release qs
      tests/launchupdate-test: fix fw_cfg leak
      igvm: release found memory region on success
      igvm: make IgvmMemoryRegion a QOM
      hw/s390x/ipl: fix short SCSI loadparm buffer over-read

 backends/igvm.c                                   | 99 ++++++++++++++---------
 hw/misc/bcm2835_powermgt.c                        |  8 ++
 hw/s390x/ipl.c                                    | 10 +--
 include/system/igvm-internal.h                    |  9 ++-
 tests/functional/hexagon/test_systests.py         |  6 +-
 tests/functional/x86_64/test_vhost_user_bridge.py | 13 +++
 tests/qtest/launchupdate-test.c                   | 20 ++---
 tests/qtest/libqos/libqos.h                       |  2 +
 8 files changed, 104 insertions(+), 63 deletions(-)
---
base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
change-id: 20260906-nohmp-next-771b029cc0f2

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


