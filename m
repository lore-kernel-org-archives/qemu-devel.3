Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E936E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 09:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXGzU-0005yA-Iq; Mon, 13 Jan 2025 04:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1tXGzS-0005y0-Ov
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 04:44:10 -0500
Received: from mail-japaneastazon11020085.outbound.protection.outlook.com
 ([52.101.229.85] helo=TY3P286CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1tXGzR-0006xQ-1E
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 04:44:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX08MBE+eruGrq5eEyvtbMa21RxckHJYQrxkt6Rm9poaLFVXQMkN3pNdgmhsPioTS/oHnnF7v16RWO5wbCXGDiiOyjXuB9bERowWw72fCFdwXhUlalDXeG0waPAa4zF+cTfXGTKpCF74dl7NlMk/5fPiWTISdPaSfnghwFBnzfHzPF/3uuS5bxU2h61eBBhAilrwSgVGoJuV+fmyv+tGJ7uaY+IXPqMwKDcKMUS4h89KW9/vVFvG7xOx+SYzdy2+3wEdOEgEzynKZjnaTQdn3YM0kWCy6vWcH+rXZ7hPU9YbofqdcCgJhOjoia8uwv6qs3utNaPNcd/+jYPxndu8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjKpMRh1FyZ0Wi2vfyDN7THDB9aZ8z3Q7BX/UwsZ+f0=;
 b=DUwAVxfr3JDsAh9LEbM0MUu5R6CzO2i1bR3KUb27Y0VUGXLaDgrnl1utDEyc43kLFxilRCwEd7npg0g44agh7ewu8x/TThreVfg1RBVf7uogWfmO9nDHSwtyqWaIunR4BoP/Ee/1ziETnnJlomfekbZtfx4iw20Z6Sp+5P5ALeYbPmOeoOEGEi5wz4WAhIWcDQOmll4NlGI3mpwsGjQtEr5kAPPTKxlJr1KkIs3lDxyIYJd+hE/3D/U5NqDgbzffMfGsh3BSDmnD1kMH4yFeDic+RYS3rJJgnP1UVuxotHB6lPOZuVfWS7wgf8m7+JFKrlm5cmXXH+byX/w710A7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjKpMRh1FyZ0Wi2vfyDN7THDB9aZ8z3Q7BX/UwsZ+f0=;
 b=Oe8RlwXqJC4JEpXU+kTRIg5SDS3d5/i2Z5igGwLIMwMMu+x2fnDgYb37QTQOKkFKA16oZi+as/9sJF4RKiStutnkKP0bGWwygZeH6juak3IWMsFatgOzxhRpEpRZNIaNEYZjs1j49tQICSYb+a2XJuDDJZOh8Ch8/7CgMSNrK5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB2685.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:244::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 09:38:59 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6%2]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 09:38:59 +0000
Date: Mon, 13 Jan 2025 17:38:56 +0800
From: Hongren Zheng <i@zenithal.me>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, contact@canokeys.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Subject: [PATCH] hw/usb/canokey: Fix buffer overflow for OUT packet
Message-ID: <Z4TfMOrZz6IQYl_h@Sun>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 contact@canokeys.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 6.6.69
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TYCP286MB2685:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a48ac0d-6842-4f7a-fcb0-08dd33b61b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ZX8l/sxKcGXRDKaJUbGoOhXYeDVDCCFCOZL6Ui6BuVQQpfULoZpX/LIy47Q?=
 =?us-ascii?Q?X079hv9yqcSbs1XlF1EbEuIWjyJWbmTZLLmLh2CTF+C8H3VHtXAnztME4Lmu?=
 =?us-ascii?Q?gYp4j+7azsz9I9Otry1DjsRe514YjX++FSSlgpj0XDIRrmhOA8IoU78sbbvX?=
 =?us-ascii?Q?hB4ZJcFG69a9xGam8HyTy9X+f3MoVoZA3+6ooLPTjdPgIMkWeCoZNbVzbZO2?=
 =?us-ascii?Q?sc2wqVARJx5h4EDctxD/3jbAQ96FqbUYGaTgRK+m+LupKoGjStwoqVfLRhMd?=
 =?us-ascii?Q?UhCN97pQu48FHMEF0LplpJ7R796oxKTqciKszLogMt3vrNQas4v3gbaRmuZE?=
 =?us-ascii?Q?WeLjaqonl5DRcH1M0+HQnG3ijSs4tp/Q5YPQPporX9lOjTTF6Oe7SnIadBvy?=
 =?us-ascii?Q?LxYZ1c/3KXWfsbVUzvJRwVt79JG/QneNImqLICBPiD2A7pwsUXlmRFEDJQ9k?=
 =?us-ascii?Q?UsOcniHYXLlJ+fDMTtFHMr/2hOwcJbTW2S99OwwqMhVS7MHAirX8FxLXJmY3?=
 =?us-ascii?Q?bIfFB/3+Nss1aikHRN7y+c8ou3vgcXsf8YT9gMRNaaz7y2XS+nqvmepI9MQ+?=
 =?us-ascii?Q?j9/c/jQ2dv+t3XraW0j/fIK9uc133q2WuXIYltxRmjWGlxE+moMVaa3faezP?=
 =?us-ascii?Q?E0X4m1wPBJTJwZ1x0PhwU+1m0xIriunpw/uUszqyzsIcielkv5P2zzOdb/Bk?=
 =?us-ascii?Q?BywF5l1qx4/zkTs3qe6zZm8pR83OtnACAcYTehu1sNlhw+4clHFFVYZvmf5o?=
 =?us-ascii?Q?BrnmsddPlSwxgh/YFlgJJFc5wCw2GznINMOroCWAf+7atVpiejTLtIk8/K0e?=
 =?us-ascii?Q?CDOEbDVrCcidrlHakihLcJfikYf4Bd1b+LwXnSzkeOFHik61n4Qj7xfREFbr?=
 =?us-ascii?Q?XWlKQfSrzjqGKRL4jM5qxRPvo2L7chyB8qHpfpMRHn6L5bUiyl3kz/5RUi14?=
 =?us-ascii?Q?72bOSc2SSY65noa0mwhI002KF5NQ/FztnulUcTdhsm0X4Y8AxChai9Eq9Fok?=
 =?us-ascii?Q?iNcGFr/YM6BPwBodFZ1uWEZ/oncnQumzXEG3+10v9mJjzFh/qehEKY3pXcjI?=
 =?us-ascii?Q?/UzbW3jIJHpgCcWzVsNHjXPIpNa1+vX31smdVGlZNYx/HPUWZh0146ddUfQN?=
 =?us-ascii?Q?KIqlGJXRLJOlmn0ysv7CihLoexGoqzGMMf0dCN9grlHdR6V09dMMNl231aNE?=
 =?us-ascii?Q?BJrxgplJyFyRfCvu6bD/7QXJ8eA9mU6pfiBv0Loz9nf0D549hX5wooF6gtHJ?=
 =?us-ascii?Q?2ldL3/Mq6rjz3zruiMtOfPEpcSRiwwP1G1l1VAjy6ibShO2htjJEwBPxGurx?=
 =?us-ascii?Q?alKC4vnQRfjy4HgkxglXwxqzhO6/S8RCw3Jia4hAdhZf/Odp77cMZukTy15c?=
 =?us-ascii?Q?nzR+oxwFdLSoUX6pqFyLECTmyJ6f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yo0nmrlu1mmjLiR9aslRiOYbJUgo361QKehhk8/op0/OJ4iVYdqp42DaBtHv?=
 =?us-ascii?Q?mLz8Ynv3yZSo5WdoiGbimZr1Rl6hM+i9byAopvOvr7tt7wqisjc2Ou7anJ41?=
 =?us-ascii?Q?UIr61f5ma0yrhkgDLPxHCnfHh7XCJifK1FwlYOlewjTZvB1TwSHrx0VDyIta?=
 =?us-ascii?Q?X3ajwHi0NioF13WTGPTyFAxf2qx55ZmrAIMdh9wSp50ZEWxFih4e1PJ3h1Kq?=
 =?us-ascii?Q?SdQoFDq7amqGjOmStrvCL4xbSGtxtKAwz1ApkKdYYG2LvYwgBDsndjMFZSRb?=
 =?us-ascii?Q?qmpi7KrtYRZqmNV9qA1IleCUqSjv8KP65WraiIb7P3Cd3G0XF3OcSkbOCsg9?=
 =?us-ascii?Q?JIN+dyFyMcEPABPOpxwdwgSE2Cf2FLkBbJEpJY+g4oy2eIW21uzGBVMaPrHK?=
 =?us-ascii?Q?mL9/A2IrJqQhjo+F/0zvWF1k2V0Uw1qtUrzKDWBcOHtNytwThZ9qLpz7FJ9z?=
 =?us-ascii?Q?CzvxxoocP72BearAWEQXjCl/S0TTuREflYCZ+bjE4pqKabKzCkKih3L4G+US?=
 =?us-ascii?Q?C3/HjcMcWma1kHKsbtAcSyQIHsC3qjpewATf2eHsLNxsp8HMRN0CGJPDwvZe?=
 =?us-ascii?Q?A+BPuPproNW+F2cQ0z78MZvbqVMLqvYBvcNqVFCuuNsdwP26TqzWeANI2FZy?=
 =?us-ascii?Q?UJLu+FHh51DK687MJ1mmGotG8kmgJZ54f8AFhsUotMI8ROgCexbIY/TYYPPU?=
 =?us-ascii?Q?iKWSmcB52d6y0nXFxafe5epGx2Z3atMa+vBcaaDMhcwKa9TMzdri7JXlrIyg?=
 =?us-ascii?Q?5kKvJjiv6fcMybvfL5ZCD8SQKkJRcbwV1oplgEPU3dQDphI7FVgeO3Q9O0xp?=
 =?us-ascii?Q?yRWr3JxoF7KzCUDIW5vkJHNazyUWitB3NzgXQwC2jivOIyRCGL3eRV0skQ1r?=
 =?us-ascii?Q?JJDcpoYwnkI7/4qCPu9stcqbGDMHWQ3d/JpXaMWpe+H4o9qPr63iYiu+oX86?=
 =?us-ascii?Q?yI0fPPKG4TdtKHT/HalXxskiJADqjij0RcbsT7B9MRf2eMlgry9EmrEDcZP1?=
 =?us-ascii?Q?NHZ4h0FPrae9TTrRSPbkzPzsNZId+KJ3wl7ITlKX43NuNPMUgK1o2Z/Pqux1?=
 =?us-ascii?Q?/Yyhi76p8V1shQqy7zgSavqPo4QvcmoTrzczd7GfWSoc5XOW8XEepRSg5SiR?=
 =?us-ascii?Q?5ns9RFsBunadRrVmt2+AijumhhJ3rXOHL3joNyRHBFHJE5fJlTRCj8eETAHp?=
 =?us-ascii?Q?i1EXdXeOCf/AIzfNuvochhYnEFcctG5z0xbGe/MRbYNQkSB/iwPlSYRJ+mYV?=
 =?us-ascii?Q?NJqgSJPA/PcVn7cBD0L7gCCfVUGsk8PFeDfJ/ndUFrsRCYdc548VU0f/mMjb?=
 =?us-ascii?Q?jOTZcG2TZWaoZp3zCrk1dc34mFQVzONhel3TQxP5y7FZzd5hjfDwAF8SLEXV?=
 =?us-ascii?Q?wu/CVu6f/7u4vbdBZqeAckDM2T2lJBJtANw7JAajF5XEGq9jqCUQ2vgm5Gjg?=
 =?us-ascii?Q?a5GHPMZkDx5md96LtCEQ/JMD9NIQYlib99KQ/qjJ5J90yJTFzp5JFcoLwyoH?=
 =?us-ascii?Q?70ku9hvPUsRzQ+8wIqCzVPISZtB3UUpqUewamedxWV3M5EzF2yY8jqeHDM0R?=
 =?us-ascii?Q?7p9DKapicbggjCiGwd+xX5oSUc87gBBSVKf4K89/?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a48ac0d-6842-4f7a-fcb0-08dd33b61b84
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 09:38:59.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY0SKjkTHriebUANOiwZQviQS4BalMxeI97gQtUjyJ7S/OKPzxsESshmOWX0cXIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2685
Received-SPF: pass client-ip=52.101.229.85; envelope-from=i@zenithal.me;
 helo=TY3P286CU002.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

When USBPacket in OUT direction has larger payload
than the ep_out_buffer (of size 512), a buffer overflow
would occur.

It could be fixed by limiting the size of usb_packet_copy
to be at most buffer size. Further optimization gets rid
of the ep_out_buffer and directly uses ep_out as the target
buffer.

This is reported by a security researcher who artificially
constructed an OUT packet of size 2047. The report has gone
through the QEMU security process, and as this device is for
testing purpose and no deployment of it in virtualization
environment is observed, it is triaged not to be a security bug.

Reported-by: Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 hw/usb/canokey.c | 6 +++---
 hw/usb/canokey.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index fae212f053..e2d66179e0 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -197,8 +197,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
     switch (p->pid) {
     case USB_TOKEN_OUT:
         trace_canokey_handle_data_out(ep_out, p->iov.size);
-        usb_packet_copy(p, key->ep_out_buffer[ep_out], p->iov.size);
         out_pos = 0;
+        /* segment packet into (possibly multiple) ep_out */
         while (out_pos != p->iov.size) {
             /*
              * key->ep_out[ep_out] set by prepare_receive
@@ -207,8 +207,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
              * to be the buffer length
              */
             out_len = MIN(p->iov.size - out_pos, key->ep_out_size[ep_out]);
-            memcpy(key->ep_out[ep_out],
-                    key->ep_out_buffer[ep_out] + out_pos, out_len);
+            /* usb_packet_copy would update the pos offset internally */
+            usb_packet_copy(p, key->ep_out[ep_out], out_len);
             out_pos += out_len;
             /* update ep_out_size to actual len */
             key->ep_out_size[ep_out] = out_len;
diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
index e528889d33..1b60d73485 100644
--- a/hw/usb/canokey.h
+++ b/hw/usb/canokey.h
@@ -24,8 +24,6 @@
 #define CANOKEY_EP_NUM 3
 /* BULK/INTR IN can be up to 1352 bytes, e.g. get key info */
 #define CANOKEY_EP_IN_BUFFER_SIZE 2048
-/* BULK OUT can be up to 270 bytes, e.g. PIV import cert */
-#define CANOKEY_EP_OUT_BUFFER_SIZE 512
 
 typedef enum {
     CANOKEY_EP_IN_WAIT,
@@ -59,8 +57,6 @@ typedef struct CanoKeyState {
     /* OUT pointer to canokey recv buffer */
     uint8_t *ep_out[CANOKEY_EP_NUM];
     uint32_t ep_out_size[CANOKEY_EP_NUM];
-    /* For large BULK OUT, multiple write to ep_out is needed */
-    uint8_t ep_out_buffer[CANOKEY_EP_NUM][CANOKEY_EP_OUT_BUFFER_SIZE];
 
     /* Properties */
     char *file; /* canokey-file */
-- 
2.47.1


