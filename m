Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43855E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCb0-0005Fq-V1; Fri, 10 Jan 2025 05:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCal-0005DQ-2G
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCai-0001Gs-Tr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGtY5GVSTX3MI326OCjLK1BWwcwRD/u49M/MaZzc0mE=;
 b=O+JxoWelHn4PAtamANGKElK+1r7vGw7KREGdunIRGQlQexsMDFHnZwhuUVwCgU92Ed1+Kx
 NtV3BxmPPkHv2uaGUsw2Ng8p1jJdxSsR7+Ju4/KdbEgdhXhdntyjxydiHBDnQAMGXvdowq
 AfKC/Y25VSKPyQhIoj33HpGBqCxjx2A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-eh3AoMrdPFa8PDV4b2XQFw-1; Fri,
 10 Jan 2025 05:50:07 -0500
X-MC-Unique: eh3AoMrdPFa8PDV4b2XQFw-1
X-Mimecast-MFC-AGG-ID: eh3AoMrdPFa8PDV4b2XQFw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA50F1955D80
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:50:06 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 090041955BE3; Fri, 10 Jan 2025 10:50:04 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v3 6/8] qapi: golang: Generate event type
Date: Fri, 10 Jan 2025 11:49:44 +0100
Message-ID: <20250110104946.74960-7-victortoso@redhat.com>
In-Reply-To: <20250110104946.74960-1-victortoso@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

This patch handles QAPI event types and generates data structures in
Go that handles it.

1. Naming: Every event type has an Event suffix.

2. Timestamp: Every event has a MessageTimestamp field with a
   reference to the Timestamp struct (not included in the QAPI spec
   but defined in docs/interop/qmp-spec.rst)

3. Every event implements the Event interface.

Example:
qapi:
 | ##
 | # @MEMORY_DEVICE_SIZE_CHANGE:
 | #
 | # Emitted when the size of a memory device changes.  Only emitted for
 | # memory devices that can actually change the size (e.g., virtio-mem
 | # due to guest action).
 | #
 | # @id: device's ID
 | #
 | # @size: the new size of memory that the device provides
 | #
 | # @qom-path: path to the device object in the QOM tree (since 6.2)
 | #
 | # .. note:: This event is rate-limited.
 | #
 | # Since: 5.1
 | #
 | # .. qmp-example::
 | #
 | #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 | #          "data": { "id": "vm0", "size": 1073741824,
 | #                    "qom-path": "/machine/unattached/device[2]" },
 | #          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
 | ##
 | { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
 |   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }

go:
 | // Emitted when the size of a memory device changes.  Only emitted for
 | // memory devices that can actually change the size (e.g., virtio-mem
 | // due to guest action).
 | //
 | // .. note:: This event is rate-limited.
 | //
 | // Since: 5.1
 | //
 | // .. qmp-example::    <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 | // "data": { "id": "vm0", "size": 1073741824,           "qom-path":
 | // "/machine/unattached/device[2]" },      "timestamp": { "seconds":
 | // 1588168529, "microseconds": 201316 } }
 | type MemoryDeviceSizeChangeEvent struct {
 | 	MessageTimestamp Timestamp `json:"-"`
 | 	// device's ID
 | 	Id *string `json:"id,omitempty"`
 | 	// the new size of memory that the device provides
 | 	Size uint64 `json:"size"`
 | 	// path to the device object in the QOM tree (since 6.2)
 | 	QomPath string `json:"qom-path"`
 | }
 |
 | func (s MemoryDeviceSizeChangeEvent) MarshalJSON() ([]byte, error) {
 |      ...
 | }
 |
 | func (s *MemoryDeviceSizeChangeEvent) UnmarshalJSON(data []byte) error {
 |      ...
 | }

usage:
 | input := `{"event":"MEMORY_DEVICE_SIZE_CHANGE",` +
 | `"timestamp":{"seconds":1588168529,"microseconds":201316},` +
 | `"data":{"id":"vm0","size":1073741824,"qom-path":"/machine/unattached/device[2]"}}`
 |
 | // Straight forward if you know the event type
 | {
 |     mdsc := MemoryDeviceSizeChangeEvent{}
 |     err := json.Unmarshal([]byte(input), &mdsc)
 |     if err != nil {
 |         panic(err)
 |     }
 |     // mdsc.QomPath == "/machine/unattached/device[2]"
 | }
 |
 | // Generic way, using Event interface and helper function
 | if event, err := GetEventType(input); err != nil {
 |     // handle bad data or unknown event
 | }
 |
 | if err := json.Unmarshal(input, event); err != nil {
 |     // handle bad data or unknown event fields
 | }
 |
 | if mdsc, ok := event.(*MemoryDeviceSizeChangeEvent); ok {
 |     // mdsc.QomPath == "/machine/unattached/device[2]"
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 143 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 330891ede9..6a8f5cf230 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -238,6 +238,73 @@
 }}
 """
 
+TEMPLATE_EVENT = """
+type Timestamp struct {{
+    Seconds      int64 `json:"seconds"`
+    Microseconds int64 `json:"microseconds"`
+}}
+
+type Event interface {{
+    json.Marshaler
+    json.Unmarshaler
+}}
+
+func marshalEvent(obj interface{{}}, name string, ts Timestamp) ([]byte, error) {{
+    m := make(map[string]any)
+    m["event"] = name
+    m["timestamp"] = ts
+    if bytes, err := json.Marshal(obj); err != nil {{
+        return []byte{{}}, err
+    }} else if len(bytes) > 2 {{
+        m["data"] = obj
+    }}
+    return json.Marshal(m)
+}}
+
+func GetEventType(data []byte) (Event, error) {{
+    tmp := struct {{
+        Name string `json:"event"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
+    }}
+
+    switch tmp.Name {{{cases}
+    default:
+        return nil, fmt.Errorf("Event %s not match to any type", tmp.Name)
+    }}
+}}
+"""
+
+TEMPLATE_EVENT_METHODS = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+	type Alias {type_name}
+	return marshalEvent(Alias(s), "{name}", s.MessageTimestamp)
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+	type Alias {type_name}
+    tmp := struct {{
+        Name string    `json:"event"`
+        Time Timestamp `json:"timestamp"`
+        Data Alias     `json:"data"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return fmt.Errorf("Failed to unmarshal: %s", string(data))
+    }}
+
+    if !strings.EqualFold(tmp.Name, "{name}") {{
+        return fmt.Errorf("Event type does not match with %s", tmp.Name)
+    }}
+
+    *s = {type_name}(tmp.Data)
+    s.MessageTimestamp = tmp.Time
+    return nil
+}}
+"""
+
 
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
@@ -300,7 +367,7 @@ def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
-def qapi_to_go_type_name(name: str) -> str:
+def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
     # We want to keep CamelCase for Golang types. We want to avoid removing
     # already set CameCase names while fixing uppercase ones, eg:
     # 1) q_obj_SocketAddress_base -> SocketAddressBase
@@ -318,6 +385,12 @@ def qapi_to_go_type_name(name: str) -> str:
 
     name += "".join(word.title() for word in words[1:])
 
+    # Handle specific meta suffix
+    types = ["event"]
+    if meta in types:
+        name = name[:-3] if name.endswith("Arg") else name
+        name += meta.title().replace(" ", "")
+
     return name
 
 
@@ -773,6 +846,16 @@ def qapi_to_golang_struct(
     if not doc_enabled:
         type_doc = ""
 
+    if info.defn_meta == "event":
+        fields.insert(
+            0,
+            {
+                "name": "MessageTimestamp",
+                "type": "Timestamp",
+                "tag": """`json:"-"`""",
+            },
+        )
+
     if members:
         for member in members:
             field_doc = docfields.get(member.name, "") if doc_enabled else ""
@@ -827,7 +910,8 @@ def qapi_to_golang_struct(
                 fields.append(field)
                 with_nullable = True if nullable else with_nullable
 
-    type_name = qapi_to_go_type_name(name)
+    type_name = qapi_to_go_type_name(name, info.defn_meta)
+
     content = string_to_code(
         generate_struct_type(
             type_name, type_doc=type_doc, args=fields, indent=indent
@@ -1005,6 +1089,21 @@ def generate_template_alternate(
     return "\n" + content
 
 
+def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
+    content = ""
+    cases = ""
+    for name in sorted(events):
+        type_name, gocode = events[name]
+        content += gocode
+        cases += f"""
+    case "{name}":
+        return &{type_name}{{}}, nil
+"""
+
+    content += string_to_code(TEMPLATE_EVENT.format(cases=cases))
+    return content
+
+
 def generate_content_from_dict(data: dict[str, str]) -> str:
     content = ""
 
@@ -1040,12 +1139,14 @@ def __init__(self, _: str):
         types = (
             "alternate",
             "enum",
+            "event",
             "helper",
             "struct",
             "union",
         )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
+        self.events: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
@@ -1084,7 +1185,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
                 imports += """
 import "encoding/json"
 """
-            elif target == "helper":
+            elif target == "helper" or target == "event":
                 imports += """
 import (
     "encoding/json"
@@ -1112,6 +1213,7 @@ def visit_end(self) -> None:
         self.target["alternate"] += generate_content_from_dict(self.alternates)
         self.target["struct"] += generate_content_from_dict(self.structs)
         self.target["union"] += generate_content_from_dict(self.unions)
+        self.target["event"] += generate_template_event(self.events)
 
     def visit_object_type(
         self,
@@ -1267,7 +1369,40 @@ def visit_event(
         arg_type: Optional[QAPISchemaObjectType],
         boxed: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.events
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        if isinstance(arg_type, QAPISchemaObjectType):
+            content = string_to_code(
+                qapi_to_golang_struct(
+                    self,
+                    name,
+                    info,
+                    arg_type.ifcond,
+                    arg_type.features,
+                    arg_type.base,
+                    arg_type.members,
+                    arg_type.branches,
+                )
+            )
+        else:
+            args: List[dict[str:str]] = []
+            args.append(
+                {
+                    "name": "MessageTimestamp",
+                    "type": "Timestamp",
+                    "tag": """`json:"-"`""",
+                }
+            )
+            content = string_to_code(
+                generate_struct_type(type_name, args=args)
+            )
+
+        content += string_to_code(
+            TEMPLATE_EVENT_METHODS.format(name=name, type_name=type_name)
+        )
+        self.events[name] = (type_name, content)
 
     def write(self, output_dir: str) -> None:
         for module_name, content in self.target.items():
-- 
2.47.1


