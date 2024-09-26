Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F0CCFA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmtc-0001Z4-Hi; Thu, 26 Sep 2024 07:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmtD-0000sw-LM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmtB-0005mu-Kj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE3F1F863;
 Thu, 26 Sep 2024 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xePc//Wf/ggnmLTg6GPxnEyvOai/DiB/Tupw9yXWOs0=;
 b=YwC2eHcgBOt8knnBexEGE++FyjalTN8aJzGk5a+XbmqReVtMw73R/3ltlm4oGo2iiZxgax
 mNiXUAcLRQARHX2wm53QB31hIOod31S3Zen3jnFCM3qY0IQYYN7RwmpGZuzDGg9STDbntB
 EnKMp9x8xcjm5gLZAnpBFSJLsPo5FWA=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=YwC2eHcg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xePc//Wf/ggnmLTg6GPxnEyvOai/DiB/Tupw9yXWOs0=;
 b=YwC2eHcgBOt8knnBexEGE++FyjalTN8aJzGk5a+XbmqReVtMw73R/3ltlm4oGo2iiZxgax
 mNiXUAcLRQARHX2wm53QB31hIOod31S3Zen3jnFCM3qY0IQYYN7RwmpGZuzDGg9STDbntB
 EnKMp9x8xcjm5gLZAnpBFSJLsPo5FWA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF03613793;
 Thu, 26 Sep 2024 11:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6NKjKKNI9WbcRAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Thu, 26 Sep 2024 11:42:27 +0000
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
Subject: [PATCH v6 12/16] backends/confidential-guest-support: Add
 set_guest_policy() function
Date: Thu, 26 Sep 2024 12:42:01 +0100
Message-ID: <a135953bee297a49bbee85f5a451c95d9d8b3acd.1727341768.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727341768.git.roy.hopkins@suse.com>
References: <cover.1727341768.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EE3F1F863
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWELVE(0.00)[19];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLgjcjk3igk5en59wt86eb8xw3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.com:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

For confidential guests a policy can be provided that defines the
security level, debug status, expected launch measurement and other
parameters that define the configuration of the confidential platform.

This commit adds a new function named set_guest_policy() that can be
implemented by each confidential platform, such as AMD SEV to set the
policy. This will allow configuration of the policy from a
multi-platform resource such as an IGVM file without the IGVM processor
requiring specific implementation details for each platform.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/confidential-guest-support.c     | 12 ++++++++++++
 include/exec/confidential-guest-support.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index c5cc6308f4..e089c74eb2 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,17 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest policy is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -52,6 +63,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index 9c97b83d11..d0b4b886e6 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -59,6 +59,10 @@ typedef enum ConfidentialGuestPageType {
     CGS_PAGE_TYPE_REQUIRED_MEMORY,
 } ConfidentialGuestPageType;
 
+typedef enum ConfidentialGuestPolicyType {
+    GUEST_POLICY_SEV,
+} ConfidentialGuestPolicyType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -125,6 +129,23 @@ typedef struct ConfidentialGuestSupportClass {
                            ConfidentialGuestPageType memory_type,
                            uint16_t cpu_index, Error **errp);
 
+    /*
+     * Set the guest policy. The policy can be used to configure the
+     * confidential platform, such as if debug is enabled or not and can contain
+     * information about expected launch measurements, signed verification of
+     * guest configuration and other platform data.
+     *
+     * The format of the policy data is specific to each platform. For example,
+     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
+     * ID block and ID authentication in the 'policy_data' parameters. The type
+     * of policy data is identified by the 'policy_type' argument.
+     */
+    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp);
+
     /*
      * Iterate the system memory map, getting the entry with the given index
      * that can be populated into guest memory.
-- 
2.43.0


