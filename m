Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6ED111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ1eI-0003NO-TT; Mon, 01 Dec 2025 06:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.mills@ngc.com>) id 1vQ1eE-0003Mt-FD
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:00:50 -0500
Received: from esa5.ngc.iphmx.com ([207.54.93.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.mills@ngc.com>) id 1vQ1e1-0002rO-IX
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ngc.com; i=@ngc.com; q=dns/txt; s=ngc2020;
 t=1764586837; x=1796122837;
 h=from:to:subject:date:message-id:mime-version;
 bh=2XmJgyWgpPTLFbj65ht6bQcPvVR4OcczFWYkjhMvjvs=;
 b=oBUr7g7j1KXksa7mEHiVmFke+kvj9+QW9R/f+JgVQqqz/46IwTjgwP4C
 55GcZfeY2qrHKcgYLbMhTa4VwKuDnl1zIYfTI4gYx9BhUBWq+WKt/Do2V
 ew6Woj9Wjbc0yTCy8pmMwT7+JYkUhNFzpwwazYd9Ndtlkh5CTFDufxC+z
 sJhauRIAfkx9T0NsG5meBOQk5/4911iSS14FVYEoPut23xxZMDWW0j2/v
 xHizNylxGWIFg1HDJ/RMpTeQCkfvjlnGZVbk7WgkzHk8uuakorxoo/GPE
 g8WbwpCZzc7kCD/FOsav/AvUJ5AhDoq28xECMUf40xo6ePdPfb6IhV6IS w==;
X-CSE-ConnectionGUID: Su4dQaOrStyPbzTguvHDHg==
X-CSE-MsgGUID: WsDkuUc6RF2WVLUDu1GJpA==
X-IronPort-AV: E=Sophos;i="6.20,240,1758603600"; d="scan'208,217";a="99603535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO XMRC0122.ngfedus.ngext.com) ([157.127.149.151])
 by esa5.ngc.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 05:00:26 -0600
Received: from XHTC3020.northgrum.com (134.223.210.94) by
 XMRC0122.ngfedus.ngext.com (157.127.149.151) with Microsoft SMTP Server id
 15.2.2562.29; Mon, 1 Dec 2025 05:00:26 -0600
Received: from XHYC3001.northgrum.com (134.223.213.160) by
 XHTC3020.northgrum.com (134.223.210.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 05:00:26 -0600
Received: from XHYC3001.northgrum.com (134.223.213.160) by
 XHYC3001.northgrum.com (134.223.213.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 05:00:26 -0600
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.180)
 by XHYC3001.northgrum.com (134.223.213.160) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 05:00:26 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=ZGWOpuUO1iFsHayGo7qXSYSMpmEeSkgZLtCSnQnki1hgIARTWNKP14dYNmBYs0V63ZNrwGzMeNzI3zhqhf7nvyghXNdUHbfv0IHPaoGz8D3oDFNrNVYvVRYIamk7rmblay7bfwzr5IBTtZNfsc+M/vgFdXjcjBWVR1ANFESBYWLgWNleOtO3txEU280wR5P8xYjr/8jaM05t00crN6QwD1w3geP0s8z9nFAGS2tyj1oSpqs7aZ2wxyWmVA/E5AQwIBoekWvvD83fPhxg1QPjeSzxIdzNprQSkqadfsH2SfHCSozM3eeFtyq7hopsLN18upav76/GFMoT4/CGLTDABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XmJgyWgpPTLFbj65ht6bQcPvVR4OcczFWYkjhMvjvs=;
 b=rrfypm9IyvLxXetlKhh6ZK0aoSsrnCfh2Uo2hSaF7n+G7WsznX0mq1T7d/+lyHPOOAoXYApzU8sNEwDpPyIM5u13Ie1dLUG+6jM+rXyuuTeESIUGugQySaJT+O/PP8EyIGWqTU1sZT4sTtD331fz6dRxxzCB/FcaWwGSp7+ZCPd9gBHnCfDdkUAyPVyNohMc9Ll8ig8nTj+cxXNZr61AOPaIJ8evDjOPa+WC5QU+0bWbhf3DqvBoJms6w2D4o5jLew2JaP75l1vqwgAIvZeq203sqXmSoWjlJ37Vn70hFNezQniTS1FOnLYZOOvahYkwvYFiHmObklpOntJ/dGKtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ngc.com; dmarc=pass action=none header.from=ngc.com; dkim=pass
 header.d=ngc.com; arc=none
Received: from BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:168::9)
 by BN2P110MB1621.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:00:24 +0000
Received: from BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2e6a:f257:d356:18a]) by BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2e6a:f257:d356:18a%6]) with mapi id 15.20.9320.013; Mon, 1 Dec 2025
 11:00:24 +0000
From: "Mills, Ryan D [US] (SP)" <r.mills@ngc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Preemption of userspace PCI device model
Thread-Topic: Preemption of userspace PCI device model
Thread-Index: AdxisZ9Bc1dOdPWbRpek6bzv9QNr8w==
Date: Mon, 1 Dec 2025 11:00:24 +0000
Message-ID: <BN2P110MB0947A58124BB23CE861C5763F4DBA@BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ngc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB0947:EE_|BN2P110MB1621:EE_
x-ms-office365-filtering-correlation-id: e1690491-4167-4cd9-9793-08de30c8d43b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZeHi/wWfsgpaQIgNC4PoyzBYCvbltUjQOaqJLc5JYpkTJtyuLO7mi+mSctQ8?=
 =?us-ascii?Q?SN61d3Bz+ubkiIC2nEVMx2SS7qHTaK6lad3SZvdovxgBxNriPGwLP3vBhUUE?=
 =?us-ascii?Q?dWMspI6jSUKVD3MzfVYcH5ZQUqHhh0cyE3Oiiq5sd8DHQLLbQBdwTQ4FEpjH?=
 =?us-ascii?Q?Nyi3DuNfvnEhPeg2OVXpAcwuRH8I8bBUMw9Qm3sXk4w3aAZo7jr1yAW07T81?=
 =?us-ascii?Q?jfEVJNXl/I328jsd0EdsyaWjk4JwLD9NgJVN4GllrGCmnJdUtsIwxl5zLeL5?=
 =?us-ascii?Q?tXigmOdwvQxz++cfHB/4a8A1FKVQFjnGsshvsYfskTSvVCc1uYDyZv8Xqj4T?=
 =?us-ascii?Q?7jSKqIyKXiG4ELo1UhfznCTvfwZIb3fZB7+1FpUKK6/T6IdcIdLwV1JtBrdE?=
 =?us-ascii?Q?ld4IwhFphQ+GDZgM+anS0s99T/TZHtbPTHFSIeSsw9/NGlAn9B3RBs5iB9Zp?=
 =?us-ascii?Q?14IBod3Mmel2JvOBjk/Vr9plnUSaMdEs4Ojnc0k4Thf2oLWLkrejh0US647r?=
 =?us-ascii?Q?x4uFFH9TgtcWwgjzKbQA1oNbdqQZLHcwG893lvbxb+6oOhozhgxMBTPP/tqx?=
 =?us-ascii?Q?2HM55/iclFdBTh9ja7GgmWGYMmgF2ICZITdFZtRc5+/PoSQS+sZI6Iu+OrLn?=
 =?us-ascii?Q?MAPm8DeWfKFTDmY1Dj0wvKi5hu7QL0uBTv+GtJB8Xv6I0dXQX+3qw4/TooXx?=
 =?us-ascii?Q?tTRvPrJqAde9j0d9bx86gvvCpRmXQC73tUeQLCzRMIxK2os2R2kpQKS+ODXy?=
 =?us-ascii?Q?lhAc7ePlU6Ryv0huq5L+URoPFm6JevG4DPpfEtZY+uIVaEsn2TB+BEnkZxAY?=
 =?us-ascii?Q?F25F1aZitUAOBeJpOVW+e2wYXvAmzO8QDqc2a7K5RHJkWd6B3wTwnEKcXo7S?=
 =?us-ascii?Q?fcVuPJyUJbufEj/cwiO1LpSd0KcVLJaau/kfk1nxrWlgAlu/1L26upDR74hg?=
 =?us-ascii?Q?VFxfYWmLiyL4Iv5anm23HIPDGyPs6pLRXO42szP5fovbdLKylSwJbVkqzp2i?=
 =?us-ascii?Q?QkS8HlXkvVNChlVaamWBAaBYpcPM349v1hAtDJLoZ181FeTFrmAZr+JzqHcI?=
 =?us-ascii?Q?YJ10U8ZbACrEa5zWSVFqyHGMrdHkzpxK5MdU+PzAKfQ30vQTmI6UrPf8khGL?=
 =?us-ascii?Q?8cVIGVS/ANAKsOFISLSsSLccZP+FgcDymEsKQonAWmWgZME2mTK9fPSSz/MA?=
 =?us-ascii?Q?0iCgEO6PRg/dR08hDHBaefdYaqS7A5ItGaB2N6d6fZQLjluQXXLaqa/lUslw?=
 =?us-ascii?Q?Ljs9Y7a5Wt5GlDo5pvKr1X6PyBB2RO/ZwOk/YKMsiCojshjx6rZ6PtKbhRfc?=
 =?us-ascii?Q?B7pR7W1GZDKo9WS9lmUDti4nRZpa9fFQ4KN8OMvW7H6yb4PrtsvwATwl8hO4?=
 =?us-ascii?Q?8fFcBIpadnMO905+iJQLXAz+jJ3xKQ+a5abUPxq+izPKR2Hmf6ufAOgkvOu1?=
 =?us-ascii?Q?OL5KjoYadGzZ8IU5SvjP53Vs0NCjeDRxsKAKoffnbmFL67/zrUNrIAkw5o83?=
 =?us-ascii?Q?OKjoxjmN/PLa2SO6qQvu86O526OgmhnioQnc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UBPin9MxjWhsbMhGPKr/VlbWnvMiFqwtayPjpxaHwGOodb97c/x6onCZr/My?=
 =?us-ascii?Q?b7EAw7pSmlu3gRfFAG9Yo4WvqYaTlHTWEenrGCPg35GmgAN+MFypHO+FqkkB?=
 =?us-ascii?Q?+LwVVBaHUtuxU2WfVsuliWgpiATKg2lDzj/07//dg6UA9kZV0tKEvW2MiwJi?=
 =?us-ascii?Q?isnj10lBq6Cv4eDfGIEyjTswM54TUQL927MZQfbSQX/SZINUKpm89WCt5GD9?=
 =?us-ascii?Q?m3FLiBaZk9CX90HJz3K5Wgu/33IVNjGYXnsXf6Ja2UfGXW9qrhIzTzLY5baF?=
 =?us-ascii?Q?UvOTObYdjYS2339c2e9SEO+pedEa2/miUvqQlatoYJDryXOrqfVjnSwedklz?=
 =?us-ascii?Q?z9NXGJapVPLJm4WazmrE7SuwBICaggMqbt0O2Fj+YD4JshvdntxPlCzSukFH?=
 =?us-ascii?Q?f7sl7+Trq3ukngnjDZoENw0kCgqA6rWdFcfQ1q2VyTLgOnAeFT2r5h0MduEl?=
 =?us-ascii?Q?PeGCIPw4e4S4b3nt2N6RFFMm9Q4oQEWTLZJseQhtZncB3V5PAR7IqH/U9FAD?=
 =?us-ascii?Q?iWR8EWJBdqIByBY5oTL7L+bhR+AJ7LCbh3lO8IgEa8XTJtsvB0+Q8XL9MssV?=
 =?us-ascii?Q?aeaM7+XXCfdQ1CmHX2GmRSqSCKDkRzFfchPIe43EVyU1xIMkupUEojWMx5+C?=
 =?us-ascii?Q?c4fIXVk0WnxfwESCYrXPK0XJWS90U5qAQJS1Num/psZnDk1sxdtQek8c1j5a?=
 =?us-ascii?Q?GfRskHt8nIXLxwHgdteDDRUpiFIHiM7EoYZm0MT2zjxRjdm9X4KdF+ELTwWK?=
 =?us-ascii?Q?t33gzbmRjW0zsGOy0RyA5GWnBLHRpmff57UUWszlYWpsDkGmdRPsvPqGz+rP?=
 =?us-ascii?Q?+3MEiMzNmCfI0Z48ryu3eKK6RSQBs9W8O83AGN72L1jClpFNjOMBbwb8GDhY?=
 =?us-ascii?Q?7r1STnRzC8Q8h097GMfkZApIuaoXifefutNDlyK9R8IE0ZI8/KCd/nppFYyJ?=
 =?us-ascii?Q?G1w5TRKAjKhqz99W8C2eMRIC40D7hcHONUqai3/8z+dkbDcMKUvlvpau3KUh?=
 =?us-ascii?Q?btGQImFYmaDpbVDX0DRqneZkPEPhiHGFpK91NCpH7T9ZC97v5ipuHbG6AjbB?=
 =?us-ascii?Q?i6t/2pAE3Sdv8RhqTsWzDI1p8Aki6JtZsL+mTYjOxAdVSKtZLzCxzfSgptgU?=
 =?us-ascii?Q?DG7lDCbIS3PQHpDD/seyDmJeU07AJz7BRgUT5ro6ZdFzUsXHULrjxMvvOzeo?=
 =?us-ascii?Q?I/7zbbsWUk9+bXHZTAChQhFBIEix9AcLNTBNoYTUrNuR63yuUaKUmU58QMNS?=
 =?us-ascii?Q?C+mtziC2v7GohSD8vVCbFS5tTinu4+VYNQvS9Kg9NNT4x1erfAJpYuWTpsVV?=
 =?us-ascii?Q?VIJdP8UAGBQtI7RIK6PiRAwgWov9E6k7qGebu13gmWs+63wPZqNMlZ270TS2?=
 =?us-ascii?Q?yZoj00rIt62v5PGSdr/Fff6Eup+Bw5UCeuqMrqO2r9tlClE35a8HocIIpqE7?=
 =?us-ascii?Q?8EPr3AmRcaU/tH388edShfCUgMH3CGZ+l/tuK7Hn4eXoh12YchwXsPyKgebH?=
 =?us-ascii?Q?xcQ4W53tNdT9uQY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN2P110MB0947A58124BB23CE861C5763F4DBABN2P110MB0947NAMP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB0947.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e1690491-4167-4cd9-9793-08de30c8d43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:00:24.4991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83116fc8-b4d8-4b27-8ddf-e8f32e080b8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1621
Received-SPF: pass client-ip=207.54.93.154; envelope-from=r.mills@ngc.com;
 helo=esa5.ngc.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BN2P110MB0947A58124BB23CE861C5763F4DBABN2P110MB0947NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am using libvfio-user to model a PCI device for QEMU. Occasionally, the P=
CI device model process gets preempted by the host, resulting in the kernel=
 driver running in QEMU thinking that the device has timed out. The kernel =
driver then begins timeout recovery logic, only for the host to resume the =
PCI device model process. This results in a non-sensical PCI device state w=
ithin the kernel driver.
I think the correct solution to this is to harden the timeout logic in the =
kernel driver code, but I was wondering if there is a way to have QEMU pend=
 for vfio device operations rather than asynchronously continue kernel exec=
ution. A single iowrite32() call in a kernel driver would realistically nev=
er take such an excessive amount of time to complete that it would cause a =
driver timeout.

--_000_BN2P110MB0947A58124BB23CE861C5763F4DBABN2P110MB0947NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I am using libvfio-user to model a PCI device for QE=
MU. Occasionally, the PCI device model process gets preempted by the host, =
resulting in the kernel driver running in QEMU thinking that the device has=
 timed out. The kernel driver then
 begins timeout recovery logic, only for the host to resume the PCI device =
model process. This results in a non-sensical PCI device state within the k=
ernel driver.<o:p></o:p></p>
<p class=3D"MsoNormal">I think the correct solution to this is to harden th=
e timeout logic in the kernel driver code, but I was wondering if there is =
a way to have QEMU pend for vfio device operations rather than asynchronous=
ly continue kernel execution. A single
 iowrite32() call in a kernel driver would realistically never take such an=
 excessive amount of time to complete that it would cause a driver timeout.=
<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN2P110MB0947A58124BB23CE861C5763F4DBABN2P110MB0947NAMP_--

