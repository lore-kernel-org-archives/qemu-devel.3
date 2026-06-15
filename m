Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46CCD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4Z-00030a-3F; Mon, 15 Jun 2026 16:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4X-0002xj-45
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4V-0002FP-QX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnu/XDNhZBPnevIcXIp/sF0jXfGvDvpqUjDIedb8ZgM=;
 b=UKq3HNd7Pt+W4V8HYnzpiWNRrhmshAgCaX9EyTgcdftLshOqfSO4Mi4fPb4V2qj/MHiX6J
 e6EMjKdDnOwvSBs6lvy6eh2nlvIrKnUpsibH7dQ3JFD/LNFB8/9mNKwnJiJ8CGro0TTUgP
 8ONtOLoeEbaeobzyj/m+1ETOl4szenI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-E6wCXHy4PTSz_FeQEHhsDQ-1; Mon,
 15 Jun 2026 16:38:11 -0400
X-MC-Unique: E6wCXHy4PTSz_FeQEHhsDQ-1
X-Mimecast-MFC-AGG-ID: E6wCXHy4PTSz_FeQEHhsDQ_1781555890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C10D618004D8; Mon, 15 Jun 2026 20:38:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8340B180058F; Mon, 15 Jun 2026 20:38:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:31 +0400
Subject: [PATCH v2 05/53] qapi/gen: fix _module_basename for multi-dash
 'what' parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-5-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S2BoGZEFYq/GkpuRjSxq1QDOG+49zZ+uxEpclFTvRGc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKNBaMSdlzFvr3C+vLX1aeN5gsCGaVuTniyv
 5EycleJukWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijQAKCRDa6OEJdZac
 5cTED/4jry7KxNwWj4co4HuSTmaDmMfrNfJRiOq8GFBMbsZH2gKOeflMSj6Qum+w3HQPFnhkO1N
 yt0ujiBcNwcxpRbXeL+bnLqfi6ut4ZQOPzjTk0VCrdtXF1N02DrUbbx2B/YWd/06esziUen96Kh
 9/xvIzgRdVDDLk+ByPrCN7mJiwI7vNOtmij0JBwl/wgHZVNm6i1f7+cJir+Gy1EM2QULF6yNu97
 Y4hS7Uv1CN4X/UhtsWV/CnrUTXAZTQ3fTgYtPWgCj8gWU5iJlYOwQt0afbM5MyFdCX60+cxkGFA
 8EpCO157VrJY6zsKmo2jrmdK8oD+S1zL+yUsZjV6hwaIM31xOBUYVFd0jO238lq4crccNkPhh23
 DSmvJDkGRpwpelPR10EAgSTZieaRTB8tKfuTVa1fXMfbUtCdfEoNxixyKPib4pTFLtCMmWbP27V
 N98fuXdGLGFEqmfIGAieEsvNeXS0PWz7bAYG7MxGYH2pUe0KuucLp91sUJBpskx73UmViaEw4Ah
 Agt+iX215Xc9ZkPdhO6pbp6hNZAactO60/riLO2dFODgTFpmqwrRHjb+fhBtOoyJNhFfGgbMtUn
 ELl4FhoBfhi/1A1NWSw5hTXdHltObiL6+IDgTsR4a4J66FaaU5mzj7XSnbSkLLenWd/3PyTeiHl
 x6+oUvB2KLcJKFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b02..690187d4280 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -300,7 +300,7 @@ def _module_basename(self, what: str, name: str) -> str:
                 ret += '-' + os.path.splitext(basename)[0]
         else:
             assert QAPISchemaModule.is_system_module(name)
-            ret += re.sub(r'-', '-' + name[2:] + '-', what)
+            ret += re.sub(r'-', '-' + name[2:] + '-', what, count=1)
         return ret
 
     def _module_filename(self, what: str, name: str) -> str:

-- 
2.54.0


