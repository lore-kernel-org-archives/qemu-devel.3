Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4DC54798
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 00:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdfiA-0005kY-Kr; Fri, 23 Feb 2024 19:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyeshwar.singh@intel.com>)
 id 1rdfi3-0005jy-Te
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 19:16:11 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyeshwar.singh@intel.com>)
 id 1rdfhw-0007mG-9B
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 19:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708733760; x=1740269760;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=FC2icsb9t5kIHoDdN7nPRWFJiLZGX1acNQnor9ZbVpY=;
 b=linzdcSKEu6Su/Sile+OKCPTdy2n4F/zaNB0VwY3MjzWEbR9DP0FlRbw
 X2QWxT/2kMF4LZiKbYygS00RjUlpl6CpH6jm6blOW0uPSQJSSVR7++3vk
 sa1Sy3h6Wg3POkq0Mpaa2PdbkEIICCBGL3sljmXaCXYB5CGTsvgWKiC1y
 rggiCVFL7Sh6NCIyPFJkRuDQImSgSAhmDHmkB2Pho2nze0z+GTCsRGsLi
 gCFRumiUnM5S5E2jdETWfK31Tx4J2g+boW7OPDbmQ62rQ5lI6+sdCU5Jl
 APiyjmKIEer2jDYLAx3geKIaCdFaYGRDWRa4VOPTleSr6RYxJvTMm1ofr A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3218235"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; d="scan'208,217";a="3218235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 16:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; d="scan'208,217";a="6044138"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Feb 2024 16:15:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 16:15:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 16:15:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 16:15:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 16:15:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3T92UF2NXeCa2QCi1tKsaMg5BBjZ+XwobAT7MgzrRYehw9dhg/rqbRvx/yVmG1JbQabnr02HIXZ4cETv5eij1yr8PzDsgpOcbhpVzikjUaKyXFF8c3BVs0gOrn3UtDesWAaRcmfakkuBv6/FuFQED8/2w/16xmSpFNSZdrcTnOcb2EYu2621m64G2OnOy7+/bJTkxFZETB1oob4DEehU9obaKbGl71D8ywQc3EIy+a6qCRDzuLB0hbpsBuKDEZDtyZGxBUcWnAjZTNbfFwq10keakrHZWLtawFJ6OFvxwwoLUAYwSXgmzqj5c6b+zT8AQE5Ho9eGsKA/hXWh80L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvx6WA+90FCm/A8jcM47rdvN9qBJqR/75BnJQjxMI+Y=;
 b=ROziXnKAYcueFC/S8U7WyojQ+ZG+YfnzxbZhExUL3KvL6/V77kOZrrRbrapodpD8eXk1vhsJVfOnoAM7D3URCUwYy/EAWo80YKRUFLSckZD9JQWvuFQ5gZhREsLuOReAJgozhvAPKSuy0BgFeFn7BXSficP0rloeVfI4ou9DPniAjqB7Mmx+lQBc1JdWXqdpBJC+Jqsg/bxVyG0xI5Gi6OGv13AplshxEPF6dLgL29SRGXx7jdY+2ZXb7zUl3SIqHBQZyPhYdxkQtbFup3zbbBtB5yOJ5YWqs7LCDZxJ8s5wTXzZKs0M9gxGU4oSKZcvcI1rHpMp/nQx+g/VGdGSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Sat, 24 Feb
 2024 00:15:48 +0000
Received: from PH8PR11MB7117.namprd11.prod.outlook.com
 ([fe80::1b2a:c439:8d8b:e42d]) by PH8PR11MB7117.namprd11.prod.outlook.com
 ([fe80::1b2a:c439:8d8b:e42d%5]) with mapi id 15.20.7339.009; Sat, 24 Feb 2024
 00:15:47 +0000
From: "Singh, Satyeshwar" <satyeshwar.singh@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "Kasireddy,
 Vivek" <vivek.kasireddy@intel.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: [PATCH 1/1] virtio-gpu: Fix HW cursor visibility
Thread-Topic: [PATCH 1/1] virtio-gpu: Fix HW cursor visibility
Thread-Index: AdpmtduBObjnxgvJTvSgt7OicH/Q7g==
Date: Sat, 24 Feb 2024 00:15:47 +0000
Message-ID: <PH8PR11MB7117E6D39BD7E9E0D318F9A79F542@PH8PR11MB7117.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7117:EE_|PH8PR11MB6950:EE_
x-ms-office365-filtering-correlation-id: 5faa1b1a-50c9-4ae4-668a-08dc34cdc000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/JORoUD+MetWzQXGwmCy908ywqgnC9qleunkPZW02+aAzZlH2ZXetZ+uf7gXj33+qgin/w3asi7G4/114Ge1/MB2ckLgZ9BcQjLqzov6A54VA02k9/XxO12NrbpqExbhPq9/FURk0QnWYQq4wkiDAvZZmZSqhlV7tZrj9WWn0E/3xCmKi9KHdx75fqnpBv/58eIyD21uN+V/rpl6wH7npYQU5lZGbEfOaGYn4d19o8He1AX6fcGdGVwB7G0cDH5dM2v/lAjonYtXeKwFx6ex8Nut5SsmbxRDDmBN0QOL932raqLdqQ2pRm0eFQEb3PyK2jiQk5y/faU1LVMtMDF6Wz8xMeSssrpUkAPpWnG/768ZIQ0ZxG9LMKvuZCtSQgzZU/ADFS7t6VcACyNwsAtA+H3jNazTJFjqGed2jlYH4CXCkhZy88xcC4erWwqG7v6s39A3R4VQZ3Bko91bXEZftULTS9zhKpDGcRUGjjnjtv/9t+xPW2yeG7ET+D2X1PVpl+nA5LLi4lByOKg/YvWeuUsz8tevnqeQZ51BblvthD8jUE+Qhkicy7DnxamfdgqTFsjhzjZjDvMLz2n3PZaHBulv2OKnwrP1bngWjEaM9YhcG5sNl5yg2tVxViX9Zof
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7117.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e2YnCTa6P7wHzGvIV5Gb64lbmB5xT4dY/c1CbcAOeaI4TNxyPoveBVHTg4?=
 =?iso-8859-1?Q?hnnaliKV5xxJkjfl4H+45JlfZ0JgH+0Mpm1ivY5UnLroxEgttfbdoJrhiW?=
 =?iso-8859-1?Q?3ceB6vrT0aPr++BELWSsEZcW8K6av/pXo14wQs99WOJ1xPrDelBhwO1AUk?=
 =?iso-8859-1?Q?8iiPukO5zLbQW/24J5jCvASC9j1wz3GlzjMfXkUPSEwi7ZpDNoevOSjmr0?=
 =?iso-8859-1?Q?mNDGWBN2yWYG9upDOI0CkPcdPpNzgvi8CQUxSs5UbnB4uR6i7dWuRNwbwD?=
 =?iso-8859-1?Q?EjyshCxb3W4d+hHOG1pM1u/gUKxi/i6xcv+nl/tfKFTIfYbb2kC9Ee3NTI?=
 =?iso-8859-1?Q?l5MEXLEw8meJevtIktq2x4btIawGoTe9alKZ2dTktvxx7J0qLLaWRzXveJ?=
 =?iso-8859-1?Q?coezqG9hJVNcMZeEHTvb5TTyFqGAlv+u2aqFiTetZffFJoJalRjEI1equT?=
 =?iso-8859-1?Q?7KyvmfWnpTrVPwclFpWlTDyFNV9xcF5AFJM9+HBTcN61p8VUjvtmWn86Cn?=
 =?iso-8859-1?Q?TNXlpJO+ozgljaY3euddQcv+GqepqzDizuhPlcFlrDpdicT0vhZkyM6Ulr?=
 =?iso-8859-1?Q?9Jg5t/DM7gZrTKZkd/gphaxujD80ArHn4C1UY0Lp5coj98Zsx/Wd/EAXxV?=
 =?iso-8859-1?Q?JVFN+DfRllMpIjpM/C9HZmo184xLOrVUPUb9B9D2G8BDpDS1yTUHjnCe0g?=
 =?iso-8859-1?Q?V6r5b61m28uCzVoIOProexrcQ+885ggsT910/Jg2zLIk/MsoUz4UuiSVgF?=
 =?iso-8859-1?Q?2bEHU+T24jb2q5h0VZbzRFibfv0giY+npfMywFfAZRXkpLVGS4u02EI3+g?=
 =?iso-8859-1?Q?6jDLj8oTM1oUR2nLXKc8g9/M7ynSSgBxEkktHa3Uyex/g8NtsvrvOeg91W?=
 =?iso-8859-1?Q?Dm8uV7Wvf6tMYUxCh2Sgp/DjLOL26MkP98qTdL6QZxoE3aAOO3cX8HGpuu?=
 =?iso-8859-1?Q?zv9+dBeKAK7wQhPLaeN83AelUa8b8d09sVe7W7vAOXbGJRla3iPCamRCm3?=
 =?iso-8859-1?Q?ePGmycjICpRQn7XliamSt3TJgxNlWow8Fzqvx9ObZT4XmdmgjCISHKpYr7?=
 =?iso-8859-1?Q?OR9fH8IBHaW01Wvm97juMdUzZ3/mGo8Kul8OizCY6uYko4joalyF24dGuJ?=
 =?iso-8859-1?Q?eE3EOBPzqtPt9zo2CbmTeOCWJbD+6ye8ZjKc+2xFzSjC4ddaiYckKZ6JiA?=
 =?iso-8859-1?Q?6AitE6vp1AMxBU0UW5xmZnfMm1FlQm2HjH/Qwtq7xrSB181+3zDDhZt7Qg?=
 =?iso-8859-1?Q?GSfwjkpPyvnWMcNeyn4VC+1Xk1AMlUfxLrajYPYkFsBIGijMhMgsIJFFzE?=
 =?iso-8859-1?Q?LZViELviFpoVA6eoJCLS/uOEGvWK1LEzhgvHc1teqOLOgnlcehAh3UMjTx?=
 =?iso-8859-1?Q?CsDCAFxmYYsk8X3PM7WdPoLs0VwzlYi3bl8SNp3ez0akvJE9/Rv90yCC3P?=
 =?iso-8859-1?Q?h9PD5F1Ozt602rH6R24dSTE68NBtbiOUX38OaLtYpU+KRFkeMrQpob29UE?=
 =?iso-8859-1?Q?XSW9y28YxG1CGGDaBo3GiGJXPcsg1LfCrt1BGP2xe0s79lobtPTHTO5Uat?=
 =?iso-8859-1?Q?DsFwwNCyrRaNIGUqtrXBS6HYlMJq/w9TwrWi7laDWjN+9rQ02lOjVjzO97?=
 =?iso-8859-1?Q?D8/J2QGz4E1cX84JIvEGoBfWhNayyjWG7I?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB7117E6D39BD7E9E0D318F9A79F542PH8PR11MB7117namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faa1b1a-50c9-4ae4-668a-08dc34cdc000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 00:15:47.3375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdJbhl8Uhv0Fw6O9WquoGYMhlw8NQ9gUqQePrcdryVXMfNW9XAeZPv47O+lsb+fXyi8cudxOLirjmufmrmLl7lKPJBIC6RsALUsxRes/LRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=satyeshwar.singh@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_PH8PR11MB7117E6D39BD7E9E0D318F9A79F542PH8PR11MB7117namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When show-cursor is on, most of the time Windows VM draws the cursor by
itself and hands it over to Qemu as a separate resource. However,
sometimes, Windows OS gives control of the cursor to applications like
Notepad. In such cases a software cursor which is part of the overall
framebuffer is drawn by the application. Windows intimates the indirect
display driver (IDD) about this change through a flag and IDD is in turn
responsible for communicating with the hypervisor (Qemu) to hide the HW
cursor. This show/hide cursor can happen any time dynamically.

Unfortunately, it seems like Qemu doesn't expect this change to happen
dynamically. The code in virtio-gpu.c was written such that
update_cursor would first call dpy_cursor_define if the cursor shape has
changed and this is not a simple move operation (which indeed is the
case when moving to a SW cursor) and then call dpy_mouse_set.
dpy_cursor_define calls toolkits like GTK but in addition to creating
the cursor content, it also calls gdk_window_set_cursor thereby setting
the cursor. It is therefore, the right function to either show or hide
the cursor but there was no code present to hide the cursor. Changing
the cursor visibility in dpy_mouse_set has two issues. First,
dpy_cursor_define already decided to display the cursor so showing the
cursor in the previous call only to hide it in dpy_mouse_set doesn't
sound right. Second, dpy_mouse_set skips the rest of the code if we
are in absolute mode so adding this code there wouldn't work in that
mode.

Qemu makes the decision of whether to show or hide the cursor by
observing the cursor->resource_id flag in virtio-gpu.c as is evident
from the lines
            dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
                  cursor->resource_id ? 1 : 0);
The last parameter is considered the "visible" parameter in gdk code.
Therefore, in this patch we continue with the same model. Instead of
changing the function prototype and changing a dozen plus files, we are
adding the visible field in QEMUCursor data structure and passing
it from virtio-gpu to the GTK code where we check if the cursor is
visible or not. If not, we simply call gdk_window_set_cursor with NULL
parameter, thereby hiding the cursor. Once Windows VM switches back to
the HW cursor, then IDD would again provide a new resource_id to Qemu
and we can start displaying it once more.

Signed-off-by: Satyeshwar Singh <satyeshwar.singh@intel.com<mailto:satyeshw=
ar.singh@intel.com>>
Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com<mailto:marcandre.lurea=
u@redhat.com>>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com<mailto:vivek.kasireddy@intel=
.com>>
Cc: Dongwon Kim <dongwon.kim@intel.com<mailto:dongwon.kim@intel.com>>

---
hw/display/virtio-gpu.c | 1 +
include/ui/console.h    | 1 +
ui/gtk.c                | 5 +++++
3 files changed, 7 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1c1ee230b3..1ae9be605b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -98,6 +98,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu=
_update_cursor *cursor)
         s->current_cursor->hot_x =3D cursor->hot_x;
         s->current_cursor->hot_y =3D cursor->hot_y;
+        s->current_cursor->visible =3D cursor->resource_id ? 1 : 0;
         if (cursor->resource_id > 0) {
             vgc->update_cursor_data(g, s, cursor->resource_id);
diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..47c39ed405 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -161,6 +161,7 @@ typedef struct QEMUCursor {
     uint16_t            width, height;
     int                 hot_x, hot_y;
     int                 refcount;
+    int                 visible;
     uint32_t            data[];
} QEMUCursor;
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..12a76de570 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -478,6 +478,11 @@ static void gd_cursor_define(DisplayChangeListener *dc=
l,
         return;
     }
+    if(!c->visible) {
+        gdk_window_set_cursor(gtk_widget_get_window(vc->gfx.drawing_area),=
 NULL);
+        return;
+    }
+
     pixbuf =3D gdk_pixbuf_new_from_data((guchar *)(c->data),
                                       GDK_COLORSPACE_RGB, true, 8,
                                       c->width, c->height, c->width * 4,
--
2.33.1


--_000_PH8PR11MB7117E6D39BD7E9E0D318F9A79F542PH8PR11MB7117namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">When show-cursor is on, most of the time W=
indows VM draws the cursor by<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">itself and hands it over to Qemu as a sepa=
rate resource. However,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">sometimes, Windows OS gives control of the=
 cursor to applications like<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Notepad. In such cases a software cursor w=
hich is part of the overall<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">framebuffer is drawn by the application. W=
indows intimates the indirect<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">display driver (IDD) about this change thr=
ough a flag and IDD is in turn<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">responsible for communicating with the hyp=
ervisor (Qemu) to hide the HW<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">cursor. This show/hide cursor can happen a=
ny time dynamically.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Unfortunately, it seems like Qemu doesn't =
expect this change to happen<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">dynamically. The code in virtio-gpu.c was =
written such that<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">update_cursor would first call dpy_cursor_=
define if the cursor shape has<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">changed and this is not a simple move oper=
ation (which indeed is the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">case when moving to a SW cursor) and then =
call dpy_mouse_set.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">dpy_cursor_define calls toolkits like GTK =
but in addition to creating<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">the cursor content, it also calls gdk_wind=
ow_set_cursor thereby setting<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">the cursor. It is therefore, the right fun=
ction to either show or hide<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">the cursor but there was no code present t=
o hide the cursor. Changing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">the cursor visibility in dpy_mouse_set has=
 two issues. First,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">dpy_cursor_define already decided to displ=
ay the cursor so showing the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">cursor in the previous call only to hide i=
t in dpy_mouse_set doesn't<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">sound right. Second, dpy_mouse_set skips t=
he rest of the code if we<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">are in absolute mode so adding this code t=
here wouldn't work in that<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">mode.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Qemu makes the decision of whether to show=
 or hide the cursor by<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">observing the cursor-&gt;resource_id flag =
in virtio-gpu.c as is evident<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">from the lines<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dpy_mouse_set(s-&gt;con, cursor-&gt;pos.x, cursor-=
&gt;pos.y,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor-&gt;res=
ource_id ? 1 : 0);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">The last parameter is considered the &quot=
;visible&quot; parameter in gdk code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Therefore, in this patch we continue with =
the same model. Instead of<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">changing the function prototype and changi=
ng a dozen plus files, we are<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">adding the visible field in QEMUCursor dat=
a structure and passing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">it from virtio-gpu to the GTK code where w=
e check if the cursor is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">visible or not. If not, we simply call gdk=
_window_set_cursor with NULL<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">parameter, thereby hiding the cursor. Once=
 Windows VM switches back to<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">the HW cursor, then IDD would again provid=
e a new resource_id to Qemu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">and we can start displaying it once more.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Signed-off-by: Satyeshwar Singh &lt;<a hre=
f=3D"mailto:satyeshwar.singh@intel.com">satyeshwar.singh@intel.com</a>&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Cc: Marc-Andr=E9 Lureau &lt;<a href=3D"mai=
lto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Cc: Vivek Kasireddy &lt;<a href=3D"mailto:=
vivek.kasireddy@intel.com">vivek.kasireddy@intel.com</a>&gt;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">Cc: Dongwon Kim &lt;<a href=3D"mailto:dong=
won.kim@intel.com">dongwon.kim@intel.com</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">hw/display/virtio-gpu.c | 1 +<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">include/ui/console.h&nbsp;&nbsp;&nbsp; | 1=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">ui/gtk.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">3 files changed, 7 insertions(+)<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">diff --git a/hw/display/virtio-gpu.c b/hw/=
display/virtio-gpu.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">index 1c1ee230b3..1ae9be605b 100644<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">--- a/hw/display/virtio-gpu.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+++ b/hw/display/virtio-gpu.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">@@ -98,6 +98,7 @@ static void update_curso=
r(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;s-&gt;current_cursor-&gt;hot_x =3D cursor-&gt;hot_x;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; s-&gt;current_cursor-&gt;hot_y =3D cursor-&gt;hot_y;<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s-&gt;current_cursor-&gt;visible =3D cursor-&gt;resource_id ? 1 : 0;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;if (cursor-&gt;resource_id &gt; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vgc-&gt;update_cursor_data(g, s, cursor-&gt;=
resource_id);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">diff --git a/include/ui/console.h b/includ=
e/ui/console.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">index a4a49ffc64..47c39ed405 100644<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">--- a/include/ui/console.h<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+++ b/include/ui/console.h<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">@@ -161,6 +161,7 @@ typedef struct QEMUCur=
sor {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; width, height;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hot_x, hot_y;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; refcount;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; visible;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data[];<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">} QEMUCursor;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">diff --git a/ui/gtk.c b/ui/gtk.c<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">index 810d7fc796..12a76de570 100644<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">--- a/ui/gtk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+++ b/ui/gtk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">@@ -478,6 +478,11 @@ static void gd_cursor=
_define(DisplayChangeListener *dcl,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp; if(!c-&gt;visible) {<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; gdk_window_set_cursor(gtk_widget_get_window(vc-&gt;gfx.drawing_area), NUL=
L);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp; pixbuf =3D gdk_pi=
xbuf_new_from_data((guchar *)(c-&gt;data),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDK_COLORSPACE_RGB, true, 8,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-&gt;width, c-&gt;height, c-&gt;width=
 * 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">--
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">2.33.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_PH8PR11MB7117E6D39BD7E9E0D318F9A79F542PH8PR11MB7117namp_--

