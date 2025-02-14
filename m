Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55722C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2Lv-0005lh-Na; Fri, 14 Feb 2025 15:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2Kc-00049t-27
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KX-00022v-Js
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSUGq8fLUZu8+pIjnKvOSl0XeErVHPfIKfXGs8FYWoc=;
 b=BGSpwnxQRdHfQBsGyBYgYfVBPb+WHLkM0CJvWVQQj3GFMh+RRDXDqg2CWuMU2vtBAbXorB
 A1XPTTdapR3Ygw33BkBUahPhsn43jMVkMLPIHUknzj5hHtyMFXqAacjF9cgQU1DyGioDFv
 +dYIdDGuEE+DWwdKXjdDpbhvBoeym3c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-hHUX8muSNG-VTszRJqRU2g-1; Fri,
 14 Feb 2025 15:30:31 -0500
X-MC-Unique: hHUX8muSNG-VTszRJqRU2g-1
X-Mimecast-MFC-AGG-ID: hHUX8muSNG-VTszRJqRU2g_1739565030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B951B196E078
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:30 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26147180056F; Fri, 14 Feb 2025 20:30:25 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 11/11] docs: add notes on Golang code generator
Date: Fri, 14 Feb 2025 21:29:44 +0100
Message-ID: <20250214202944.69897-12-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The goal of this patch is converge discussions into a documentation,
to make it easy and explicit design decisions, known issues and what
else might help a person interested in how the Go module is generated.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 docs/devel/index-build.rst          |   1 +
 docs/devel/qapi-golang-code-gen.rst | 420 ++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+)
 create mode 100644 docs/devel/qapi-golang-code-gen.rst

diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 0745c81a26..13cc0646c6 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -12,4 +12,5 @@ some of the basics if you are adding new files and targets to the build.
    kconfig
    docs
    qapi-code-gen
+   qapi-golang-code-gen
    control-flow-integrity
diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-golang-code-gen.rst
new file mode 100644
index 0000000000..b39c14cfd5
--- /dev/null
+++ b/docs/devel/qapi-golang-code-gen.rst
@@ -0,0 +1,420 @@
+==========================
+QAPI Golang code generator
+==========================
+
+..
+   Copyright (C) 2025 Red Hat, Inc.
+
+   This work is licensed under the terms of the GNU GPL, version 2 or
+   later.  See the COPYING file in the top-level directory.
+
+
+Introduction
+============
+
+This document provides information of how the generated Go code maps
+with the QAPI specification, clarifying design decisions when needed.
+
+
+Scope of the generated Go code
+==============================
+
+The scope is to provide data structures that can interpret and be used
+to generate valid QMP messages. These data structures are generated
+from a QAPI schema and should be able to handle QMP messages from the
+same schema.
+
+We also provide interfaces for Commands and Events which allows an
+abstraction for client and server applications with the possibility of
+custom back end implantations.
+
+The generated Go code is a Go module with data structs that uses Go
+standard library ``encoding/json``, implementing its field tags and
+Marshal interface whenever needed.
+
+
+QAPI Documentation
+==================
+
+The documentation included in QAPI schema such as type and type's
+fields information, comments, examples and more, they are converted
+and embed in the Go generated source code. Metadata information that
+might not be relevant to developers are excluded (e.g: TODOs)
+
+
+QAPI types to Go structs
+========================
+
+Enum
+----
+
+Enums are mapped as strings in Go, using a specified string type per
+Enum to help with type safety in the Go application.
+
+::
+
+    { 'enum': 'HostMemPolicy',
+      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
+
+.. code-block:: go
+
+    // Host memory policy types
+    //
+    // Since: 2.1
+    type HostMemPolicy string
+
+    const (
+        // restore default policy, remove any nondefault policy
+        HostMemPolicyDefault HostMemPolicy = "default"
+        // set the preferred host nodes for allocation
+        HostMemPolicyPreferred HostMemPolicy = "preferred"
+        // a strict policy that restricts memory allocation to the host nodes specified
+        HostMemPolicyBind HostMemPolicy = "bind"
+        // memory allocations are interleaved across the set of host nodes specified
+        HostMemPolicyInterleave HostMemPolicy = "interleave"
+    )
+
+
+Struct
+------
+
+The mapping between a QAPI struct in Go struct is very straightforward.
+ - Each member of the QAPI struct has its own field in a Go struct.
+ - Optional members are pointers type with 'omitempty' field tag set
+
+One important design decision was to _not_ embed base struct, copying
+the base members to the original struct. This reduces the complexity
+for the Go application.
+
+::
+
+    { 'struct': 'BlockExportOptionsNbdBase',
+      'data': { '*name': 'str', '*description': 'str' } }
+
+    { 'struct': 'BlockExportOptionsNbd',
+      'base': 'BlockExportOptionsNbdBase',
+      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
+                '*allocation-depth': 'bool' } }
+
+.. code-block:: go
+
+    // An NBD block export (distinct options used in the NBD branch of
+    // block-export-add).
+    //
+    // Since: 5.2
+    type BlockExportOptionsNbd struct {
+        // Export name. If unspecified, the @device parameter is used as
+        // the export name. (Since 2.12)
+        Name *string `json:"name,omitempty"`
+        // Free-form description of the export, up to 4096 bytes. (Since
+        // 5.0)
+        Description *string `json:"description,omitempty"`
+        // Also export each of the named dirty bitmaps reachable from
+        // @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT
+        // with the metadata context name "qemu:dirty-bitmap:BITMAP" to
+        // inspect each bitmap. Since 7.1 bitmap may be specified by
+        // node/name pair.
+        Bitmaps []BlockDirtyBitmapOrStr `json:"bitmaps,omitempty"`
+        // Also export the allocation depth map for @device, so the NBD
+        // client can use NBD_OPT_SET_META_CONTEXT with the metadata
+        // context name "qemu:allocation-depth" to inspect allocation
+        // details. (since 5.2)
+        AllocationDepth *bool `json:"allocation-depth,omitempty"`
+    }
+
+
+Union
+-----
+
+Unions in QAPI are bounded to a Enum type which provides all possible
+branches of the union. The most important caveat here is that the Union
+does not need to have a complex type implemented for all possible
+branches of the Enum. Receiving a enum value of a empty branch is valid.
+
+The generated Go struct will then define a field for each
+Enum value. The type for Enum values of empty branch is bool. Only one
+field can be set at time.
+
+::
+
+    { 'union': 'ImageInfoSpecificQCow2Encryption',
+      'base': 'ImageInfoSpecificQCow2EncryptionBase',
+      'discriminator': 'format',
+      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
+
+    { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
+      'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
+
+    { 'enum': 'BlockdevQcow2EncryptionFormat',
+      'data': [ 'aes', 'luks' ] }
+
+.. code-block:: go
+
+    type ImageInfoSpecificQCow2Encryption struct {
+        // Variants fields
+        Luks *QCryptoBlockInfoLUKS `json:"-"`
+        // Empty branched enum fields
+        Aes bool `json:"-"`
+    }
+
+    func (s ImageInfoSpecificQCow2Encryption) MarshalJSON() ([]byte, error) {
+        // ...
+        // Logic for branched Enum
+        if s.Luks != nil && err == nil {
+            if len(bytes) != 0 {
+                err = errors.New(`multiple variant fields set`)
+            } else if err = unwrapToMap(m, s.Luks); err == nil {
+                m["format"] = BlockdevQcow2EncryptionFormatLuks
+                bytes, err = json.Marshal(m)
+            }
+        }
+
+        // Logic for unbranched Enum
+        if s.Aes && err == nil {
+            if len(bytes) != 0 {
+                err = errors.New(`multiple variant fields set`)
+            } else {
+                m["format"] = BlockdevQcow2EncryptionFormatAes
+                bytes, err = json.Marshal(m)
+            }
+        }
+
+        // ...
+        // Handle errors
+    }
+
+
+    func (s *ImageInfoSpecificQCow2Encryption) UnmarshalJSON(data []byte) error {
+        // ...
+
+        switch tmp.Format {
+        case BlockdevQcow2EncryptionFormatLuks:
+            s.Luks = new(QCryptoBlockInfoLUKS)
+            if err := json.Unmarshal(data, s.Luks); err != nil {
+                s.Luks = nil
+                return err
+            }
+        case BlockdevQcow2EncryptionFormatAes:
+            s.Aes = true
+
+        default:
+            return fmt.Errorf("error: unmarshal: ImageInfoSpecificQCow2Encryption: received unrecognized value: '%s'",
+                tmp.Format)
+        }
+        return nil
+    }
+
+
+Alternate
+---------
+
+Like Unions, alternates can have branches. Unlike Unions, they don't
+have a discriminator field and each branch should be a different class
+of Type entirely (e.g: You can't have two branches of type int in one
+Alternate).
+
+While the marshalling is similar to Unions, the unmarshalling uses a
+try-and-error approach, trying to fit the data payload in one of the
+Alternate fields.
+
+The biggest caveat is handling Alternates that can take JSON Null as
+value. The issue lies on ``encoding/json`` library limitation where
+unmarshalling JSON Null data to a Go struct which has the 'omitempty'
+field as it will bypass the Marshal interface. The same happens when
+marshalling, if the field tag 'omitempty' is used, a nil pointer would
+never be translated to null JSON value. The problem here is that we do
+use pointer to type plus ``omitempty`` field to express a QAPI
+optional member.
+
+In order to handle JSON Null, the generator needs to do the following:
+  - Read the QAPI schema prior to generate any code and cache
+    all alternate types that can take JSON Null
+  - For all Go structs that should be considered optional and they type
+    are one of those alternates, do not set ``omitempty`` and implement
+    Marshal interface for this Go struct, to properly handle JSON Null
+  - In the Alternate, uses a boolean 'IsNull' to express a JSON Null
+    and implement the AbsentAlternate interface, to help structs know
+    if a given Alternate type should be considered Absent (not set) or
+    any other possible Value, including JSON Null.
+
+::
+
+    { 'alternate': 'BlockdevRefOrNull',
+      'data': { 'definition': 'BlockdevOptions',
+                'reference': 'str',
+                'null': 'null' } }
+
+.. code-block:: go
+
+    // Reference to a block device.
+    //
+    // Since: 2.9
+    type BlockdevRefOrNull struct {
+        // defines a new block device inline
+        Definition *BlockdevOptions
+        // references the ID of an existing block device. An empty string
+        // means that no block device should be referenced. Deprecated;
+        // use null instead.
+        Reference *string
+        // No block device should be referenced (since 2.10)
+        IsNull bool
+    }
+
+    func (s *BlockdevRefOrNull) ToAnyOrAbsent() (any, bool) {
+        if s != nil {
+            if s.IsNull {
+                return nil, false
+            } else if s.Definition != nil {
+                return *s.Definition, false
+            } else if s.Reference != nil {
+                return *s.Reference, false
+            }
+        }
+
+        return nil, true
+    }
+
+    func (s BlockdevRefOrNull) MarshalJSON() ([]byte, error) {
+        if s.IsNull {
+            return []byte("null"), nil
+        } else if s.Definition != nil {
+            return json.Marshal(s.Definition)
+        } else if s.Reference != nil {
+            return json.Marshal(s.Reference)
+        }
+        return []byte("{}"), nil
+    }
+
+    func (s *BlockdevRefOrNull) UnmarshalJSON(data []byte) error {
+        // Check for json-null first
+        if string(data) == "null" {
+            s.IsNull = true
+            return nil
+        }
+        // Check for BlockdevOptions
+        {
+            s.Definition = new(BlockdevOptions)
+            if err := StrictDecode(s.Definition, data); err == nil {
+                return nil
+            }
+            s.Definition = nil
+        }
+
+        // Check for string
+        {
+            s.Reference = new(string)
+            if err := StrictDecode(s.Reference, data); err == nil {
+                return nil
+            }
+            s.Reference = nil
+        }
+
+        return fmt.Errorf("Can't convert to BlockdevRefOrNull: %s", string(data))
+    }
+
+
+Event
+-----
+
+Each event is mapped to its own struct with.
+
+::
+
+    { 'event': 'SHUTDOWN',
+      'data': { 'guest': 'bool',
+                'reason': 'ShutdownCause' } }
+
+.. code-block:: go
+
+    // Emitted when the virtual machine has shut down, indicating that
+    // qemu is about to exit.
+    //
+    // .. note:: If the command-line option "-no-shutdown" has been
+    // specified, qemu will not exit, and a STOP event will eventually
+    // follow the SHUTDOWN event.
+    //
+    // Since: 0.12
+    //
+    // .. qmp-example::    <- { "event": "SHUTDOWN",      "data": {
+    // "guest": true, "reason": "guest-shutdown" },      "timestamp": {
+    // "seconds": 1267040730, "microseconds": 682951 } }
+    type ShutdownEvent struct {
+        // If true, the shutdown was triggered by a guest request (such as
+        // a guest-initiated ACPI shutdown request or other hardware-
+        // specific action) rather than a host request (such as sending
+        // qemu a SIGINT). (since 2.10)
+        Guest bool `json:"guest"`
+        // The @ShutdownCause which resulted in the SHUTDOWN. (since 4.0)
+        Reason ShutdownCause `json:"reason"`
+    }
+
+
+Command
+-------
+
+Each commands is mapped to its own struct. If the command has a boxed
+data struct, the option struct will be embed in the command struct.
+
+The return value is always a well defined type and it is part of first
+layer unmarshalling type, Message.
+
+::
+
+   { 'command': 'set_password',
+     'boxed': true,
+     'data': 'SetPasswordOptions' }
+     
+    { 'union': 'SetPasswordOptions',
+      'base': { 'protocol': 'DisplayProtocol',
+                'password': 'str',
+                '*connected': 'SetPasswordAction' },
+      'discriminator': 'protocol',
+      'data': { 'vnc': 'SetPasswordOptionsVnc' } }
+
+.. code-block:: go
+
+    // Set the password of a remote display server.
+    // Errors:   - If Spice is not enabled, DeviceNotFound
+    //
+    // Since: 0.14
+    //
+    // .. qmp-example::    -> { "execute": "set_password", "arguments": {
+    // "protocol": "vnc",                           "password": "secret" }
+    // }   <- { "return": {} }
+    type SetPasswordCommand struct {
+        SetPasswordOptions
+    }
+
+Now an example of a command without boxed type.
+
+::
+
+    { 'command': 'set_link',
+      'data': {'name': 'str', 'up': 'bool'} }
+
+.. code-block:: go
+
+    // Sets the link status of a virtual network adapter.
+    //
+    // Errors:   - If @name is not a valid network device, DeviceNotFound
+    //
+    // Since: 0.14
+    //
+    // .. note:: Not all network adapters support setting link status.
+    // This command will succeed even if the network adapter does not
+    // support link status notification.  .. qmp-example::    -> {
+    // "execute": "set_link",      "arguments": { "name": "e1000.0", "up":
+    // false } }   <- { "return": {} }
+    type SetLinkCommand struct {
+        // the device name of the virtual network adapter
+        Name string `json:"name"`
+        // true to set the link status to be up
+        Up bool `json:"up"`
+    }
+
+Known issues
+============
+
+- Type names might not follow proper Go convention. Andrea suggested an
+  annotation to the QAPI schema that could solve it.
+  https://lists.gnu.org/archive/html/qemu-devel/2022-05/msg00127.html
-- 
2.48.1


