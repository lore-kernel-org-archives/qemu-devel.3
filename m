Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB72BC5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSaN-0003YM-I5; Tue, 03 Jun 2025 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMSaD-0003Wh-AD
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMSa7-0000Nz-Gn
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748960733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVdv9nNUFLGfCwtgGPonjogyUkhdnoeOBS1akhgNSXU=;
 b=SGNd/U82pedC+u/LO9WpqQG1zE5QTWYNdjoel80BMG02hy5xefpZMldPwyTMgfXQiwD1gz
 tghroLIOkPqHgQZif4u+fNhgkLIPVblLy+sDhDs+Uaix8Gb+epnwlM/lwrcUzvmJ4ybkmM
 OAPOMaoMAoOC/awS4z2rvxObpF7XWbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-giUV7bjCNn6lAyTtwdEWPg-1; Tue,
 03 Jun 2025 10:25:29 -0400
X-MC-Unique: giUV7bjCNn6lAyTtwdEWPg-1
X-Mimecast-MFC-AGG-ID: giUV7bjCNn6lAyTtwdEWPg_1748960728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03DC61956050; Tue,  3 Jun 2025 14:25:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 435EF180009F; Tue,  3 Jun 2025 14:25:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4092121E66AD; Tue, 03 Jun 2025 16:25:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/3] docs: define policy limiting the inclusion of
 generated files
Date: Tue,  3 Jun 2025 16:25:23 +0200
Message-ID: <20250603142524.4043193-3-armbru@redhat.com>
In-Reply-To: <20250603142524.4043193-1-armbru@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Files contributed to QEMU are generally expected to be provided in the
preferred format for manipulation. IOW, we generally don't expect to
have generated / compiled code included in the tree, rather, we expect
to run the code generator / compiler as part of the build process.

There are some obvious exceptions to this seen in our existing tree, the
biggest one being the inclusion of many binary firmware ROMs. A more
niche example is the inclusion of a generated eBPF program. Or the CI
dockerfiles which are mostly auto-generated. In these cases, however,
the preferred format source code is still required to be included,
alongside the generated output.

Tools which perform user defined algorithmic transformations on code are
not considered to be "code generators". ie, we permit use of coccinelle,
spell checkers, and sed/awk/etc to manipulate code. Such use of automated
manipulation should still be declared in the commit message.

One off generators which create a boilerplate file which the author then
fills in, are acceptable if their output has clear copyright and license
status. This could be where a contributor writes a throwaway python
script to automate creation of some mundane piece of code for example.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/code-provenance.rst | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 4fc12061b5..c27d8fe649 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -216,3 +216,58 @@ mailing list.
 It is also recommended to attempt to contact the original author to let them
 know you are interested in taking over their work, in case they still intended
 to return to the work, or had any suggestions about the best way to continue.
+
+Inclusion of generated files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Files in patches contributed to QEMU are generally expected to be provided
+only in the preferred format for making modifications. The implication of
+this is that the output of code generators or compilers is usually not
+appropriate to contribute to QEMU.
+
+For reasons of practicality there are some exceptions to this rule, where
+generated code is permitted, provided it is also accompanied by the
+corresponding preferred source format. This is done where it is impractical
+to expect those building QEMU to run the code generation or compilation
+process. A non-exhaustive list of examples is:
+
+ * Images: where an bitmap image is created from a vector file it is common
+   to include the rendered bitmaps at desired resolution(s), since subtle
+   changes in the rasterization process / tools may affect quality. The
+   original vector file is expected to accompany any generated bitmaps.
+
+ * Firmware: QEMU includes pre-compiled binary ROMs for a variety of guest
+   firmwares. When such binary ROMs are contributed, the corresponding source
+   must also be provided, either directly, or through a git submodule link.
+
+ * Dockerfiles: the majority of the dockerfiles are automatically generated
+   from a canonical list of build dependencies maintained in tree, together
+   with the libvirt-ci git submodule link. The generated dockerfiles are
+   included in tree because it is desirable to be able to directly build
+   container images from a clean git checkout.
+
+ * eBPF: QEMU includes some generated eBPF machine code, since the required
+   eBPF compilation tools are not broadly available on all targetted OS
+   distributions. The corresponding eBPF C code for the binary is also
+   provided. This is a time-limited exception until the eBPF toolchain is
+   sufficiently broadly available in distros.
+
+In all cases above, the existence of generated files must be acknowledged
+and justified in the commit that introduces them.
+
+Tools which perform changes to existing code with deterministic algorithmic
+manipulation, driven by user specified inputs, are not generally considered
+to be "generators".
+
+For instance, using Coccinelle to convert code from one pattern to another
+pattern, or fixing documentation typos with a spell checker, or transforming
+code using sed / awk / etc, are not considered to be acts of code
+generation. Where an automated manipulation is performed on code, however,
+this should be declared in the commit message.
+
+At times contributors may use or create scripts/tools to generate an initial
+boilerplate code template which is then filled in to produce the final patch.
+The output of such a tool would still be considered the "preferred format",
+since it is intended to be a foundation for further human authored changes.
+Such tools are acceptable to use, provided they follow a deterministic process
+and there is clearly defined copyright and licensing for their output.
-- 
2.48.1


