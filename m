Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D8C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wu9-0005xK-Vi; Mon, 07 Sep 2026 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wu7-0005wv-J3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wu4-0007Ya-9Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZI340wnoJNmaxFiuBuq9W0rbmOqS1tS0lWNDAA5ogiY=;
 b=ikf1Efjb8pp5nD/1cjbluGo6TDEF6BTsC6YNvD2J4E6PqoH3cA2q76g8JZpZwOJUfZA5Iu
 riRbVyAOxDQiZWQ4bNeaSof9pOySegmKRxNy6Kd1yvspI/0sYZCShV9d6zTapgxuJJHxrF
 a7dzaQTNhLgI4jUh/bpUaVywBk2wetM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-MTwnO6R-MLORNFqGus4a_A-1; Mon,
 07 Sep 2026 06:48:38 -0400
X-MC-Unique: MTwnO6R-MLORNFqGus4a_A-1
X-Mimecast-MFC-AGG-ID: MTwnO6R-MLORNFqGus4a_A_1788778117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D49011801363; Mon,  7 Sep 2026 10:48:36 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC5E21956044; Mon,  7 Sep 2026 10:48:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/17] Various QGA VSS fixes
Date: Mon, 07 Sep 2026 14:48:24 +0400
Message-Id: <20260907-qga-v1-0-86456ad356e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMj3cL0RF2zJAMzS1OD5BQLSzMloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0A0i72xmcAAAA=
X-Change-ID: 20260902-qga-6b06950cd896
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ckm8lND1B+Ti0mq7I485fZb2hNiK0LRoHkyQLKRtXHQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpaA2yyOg054D66eTnGFIzQhirvZrt1HKYker
 KfcnpINNryJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6WgAAKCRDa6OEJdZac
 5dOhEACY4ZcXn+YewCZC1a3sUwOxJD33PvLeI6CF3f5RAljPhxmqA/8fU4vI0cXh6NAUM+QLwdH
 IQhwdoRZj8AHEFTXOKgjMYgAwD4+yLAq0jvhHw1enz37xMWA9f530u/zehNvYYNsh+Tju0GHNhO
 dzpnLuyS6nAh3E3mOT5GqnV0djQNt+vWR8tveAIeyIKEMOIaeadxyqBfNWTA0C0j4VZw2Rjb/hR
 oL52IpFL76zRfsiX6tQlEqLSAojhONO9k6k4dLceKbcT+O+XRtXZhXonee1S7MZ5mOQTdirMXgt
 XWmvlIYMzxR3E5HLKJgTlotVQvt03OiKgiineXwf4hhlioSxyjYIrzmQYI06iqdUaAnxqUck7A4
 3CjPtsatCWIIxUkWtZcB5zrreKxFR0z0TAQmc83MeiROVaXkh6TJX7bHJuEiv5Jfx6GcHhyegiW
 4ffq7w/QbMYvyYAaJQ66Pdl5jLFRs8N30GtAf/k9/1xF7JAcmb5kd9KkMICWcKSap+IfKdK9MM4
 0FFQwfSmxdVkKMZhZHO9bO6gDI66l1W8ZXUN1zluSey/arHhonMXUwoZgSkKzttyx2qIwvtWYCT
 akIg3IpWXXMver0jxH2yRWmcvG1KtJ5P89Ddh4yF7AqDATdtXDjG1/fTpBn+FXfH3cchOU9nY9A
 6rFJ42sPsARcjEw==
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

Hi,

While studying QGA VSS code, I collected some correctness and robustness
patches.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (17):
      qga/installer: preserve VssOption registry value across upgrades
      qga/vss-win32: fix race condition in COM Release() methods
      qga/vss-win32: pass valid SERVICE_STATUS to ControlService
      qga/vss-win32: explicit NULL/zero initialization
      qga/vss-win32: free bstrWriterName in outer writer loop
      qga/vss-win32: pass character count instead of byte count to volume APIs
      qga/vss-win32: allow pceltFetched==NULL in IEnumObject::Next
      qga/vss-win32: return an interface pointer for IID_IUnknown
      qga/vss-win32: use GetLastError() after FindFirstVolumeW failure
      qga/vss-win32: guard CloseServiceHandle calls against NULL handles
      qga/vss-win32: avoid CRT calls in DllMain debug logging
      qga/vss-win32: evaluate err_set() macro argument only once
      qga/vss-win32: report QueryStatus return value on failure
      qga/vss-win32: check GetLastError() after FindNextVolumeW failure
      qga/vss-win32: initialize *num_vols at start of requester_freeze
      qga/vss-win32: restrict access to freeze/thaw synchronisation events
      qga/vss-win32: log to file during COM+ registration

 qga/installer/qemu-ga.wxs   | 19 ++++++++--
 qga/vss-win32/install.cpp   | 31 ++++++++++++++---
 qga/vss-win32/provider.cpp  | 17 +++++----
 qga/vss-win32/requester.cpp | 85 +++++++++++++++++++++++++++++++++++++--------
 4 files changed, 124 insertions(+), 28 deletions(-)
---
base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
change-id: 20260902-qga-6b06950cd896

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


