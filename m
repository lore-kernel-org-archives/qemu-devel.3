Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F59CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryXs-0001s3-N4; Wed, 03 Apr 2024 07:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXp-0001iJ-Mp
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXd-0007Rf-Ng
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:41 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E52B65CB83;
 Wed,  3 Apr 2024 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1712142744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMCdxyin7kO1xmDr2rCFckdFmb9WrVUeNAx/zK7ScS8=;
 b=ilg/1hCT5O05/0LMwxsTIE6BUAgeCzbI58/heZElAGx3Ng58OhOPtoVy2bS+6D9vFsl7si
 KFbzOPU2CGfmSU9fCOd4N0uQYGH2KNXoXtdsX3ONqlU+WNKw12aATcmXypGh99weXaL1Uw
 GLqyiFYImv3xYuyV8BtfmnLPWfv6CvI=
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EB8C413357;
 Wed,  3 Apr 2024 11:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mLzENpc5DWayHQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Apr 2024 11:12:23 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v2 02/10] backends/confidential-guest-support: Add IGVM file
 parameter
Date: Wed,  3 Apr 2024 12:11:33 +0100
Message-ID: <af70dfcfeddf36d860ff28765ee30bdde2b2c110.1712141833.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712141833.git.roy.hopkins@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[19]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]; 
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_DKIM_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E52B65CB83
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order to add support for parsing IGVM files for secure virtual
machines, a the path to an IGVM file needs to be specified as
part of the guest configuration. It makes sense to add this to
the ConfidentialGuestSupport object as this is common to all secure
virtual machines that potentially could support IGVM based
configuration.

This patch allows the filename to be configured via the QEMU
object model in preparation for subsequent patches that will read and
parse the IGVM file.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 backends/confidential-guest-support.c     | 21 +++++++++++++++++++++
 include/exec/confidential-guest-support.h |  9 +++++++++
 qapi/qom.json                             | 13 +++++++++++++
 qemu-options.hx                           |  8 +++++++-
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 052fde8db0..da436fb736 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -20,8 +20,29 @@ OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
+#if defined(CONFIG_IGVM)
+static char *get_igvm(Object *obj, Error **errp)
+{
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+    return g_strdup(cgs->igvm_filename);
+}
+
+static void set_igvm(Object *obj, const char *value, Error **errp)
+{
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+    g_free(cgs->igvm_filename);
+    cgs->igvm_filename = g_strdup(value);
+}
+#endif
+
 static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
 {
+#if defined(CONFIG_IGVM)
+    object_class_property_add_str(oc, "igvm-file",
+        get_igvm, set_igvm);
+    object_class_property_set_description(oc, "igvm-file",
+        "Set the IGVM filename to use");
+#endif
 }
 
 static void confidential_guest_support_init(Object *obj)
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index ba2dd4b5df..ec74da8877 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -51,6 +51,15 @@ struct ConfidentialGuestSupport {
      * so 'ready' is not set, we'll abort.
      */
     bool ready;
+
+#if defined(CONFIG_IGVM)
+    /*
+     * igvm_filename: Optional filename that specifies a file that contains
+     *                the configuration of the guest in Independent Guest
+     *                Virtual Machine (IGVM) format.
+     */
+    char *igvm_filename;
+#endif
 };
 
 typedef struct ConfidentialGuestSupportClass {
diff --git a/qapi/qom.json b/qapi/qom.json
index 85e6b4f84a..5935e1b7a6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -874,6 +874,18 @@
   'base': 'RngProperties',
   'data': { '*filename': 'str' } }
 
+##
+# @ConfidentialGuestProperties:
+#
+# Properties common to objects that are derivatives of confidential-guest-support.
+#
+# @igvm-file: IGVM file to use to configure guest (default: none)
+#
+# Since: 9.1
+##
+{ 'struct': 'ConfidentialGuestProperties',
+  'data': { '*igvm-file': 'str' } }
+
 ##
 # @SevGuestProperties:
 #
@@ -901,6 +913,7 @@
 # Since: 2.12
 ##
 { 'struct': 'SevGuestProperties',
+  'base': 'ConfidentialGuestProperties',
   'data': { '*sev-device': 'str',
             '*dh-cert-file': 'str',
             '*session-file': 'str',
diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..0466bb048b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5655,7 +5655,7 @@ SRST
                  -object secret,id=sec0,keyid=secmaster0,format=base64,\\
                      data=$SECRET,iv=$(<iv.b64)
 
-    ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file,kernel-hashes=on|off]``
+    ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file,kernel-hashes=on|off,igvm-file=file]``
         Create a Secure Encrypted Virtualization (SEV) guest object,
         which can be used to provide the guest memory encryption support
         on AMD processors.
@@ -5699,6 +5699,12 @@ SRST
         cmdline to a designated guest firmware page for measured Linux
         boot with -kernel. The default is off. (Since 6.2)
 
+        The ``igvm-file`` is an optional parameter that, when specified,
+        allows an Independent Guest Virtual Machine (IGVM) file to be
+        specified that configures the secure virtual machine and can
+        include, for example, an SVSM module, system firmware, initial
+        boot state, etc.
+
         e.g to launch a SEV guest
 
         .. parsed-literal::
-- 
2.43.0


