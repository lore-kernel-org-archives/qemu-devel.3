Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55267CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 06:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQBM-0004hQ-U4; Mon, 24 Nov 2025 01:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQBH-0004fA-Rf
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:36:12 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQBE-0005t9-E7
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oywvk1G4e7H1k9zNlSvZJL1lpOC5VIhu/4onk46kGkQyz1Krv6U2Cd656O4PmmRz+Plqx9NZSJ+EEIsNgzDApmq3nnpHJjz0aYopqnIrPzT8cGjs0cwnUyiJ22suOH/2EuGxCNxzUYzTuE9h8OpxTGw0gmax9PRyn4+KeOUTqrTA+iP9pSKrh0Vtc4BCaRhDrQaLN7H0W8jc1XyKTFTWLKcaR8oxFC9EyymHonN+nGV9dqtbIfjyNXUh2yu5AGWY1V3H1wii14YPgYq3/elRrlOjujmRcNhX5PJvn1R3qPSk1OpaWuHRgi3Vml1tPaaG+8BBg4hI/11+5ZKcPjM3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5EKxe12Mplodzop8FSWH9+91kt1Gscjg9+APlZPqFM=;
 b=Xii9xFKLAG7/zhxXWVA6f1emQkdP7D8l7NVzsF4UGnSUY/LURkSeRNDgkUSjtRt0veZtNq9E30Ckt8MofdY+XEW/hxx5KsjkH+65BxXlDWBemJrh0A7pUrZuj1gBlMhAwaEYfS9YgCp84Lr+QG7muUwtTZ+HPEVz0z66jf5bg1a5RQlQ5fY4eTGqCCR9m/jjCFaPY7aOJcK7L+kLNke4t1xB0lMMPhcvpTsaiTbpod+fzbCtH6sHLYOM6nnEaokvK/oo00Pao9gd0kldbUfsNjcvmRIs8SAMgoEK71pPNrbD97yYlc0Rw+pqwpsIMfRHuLqR3xDh41Mf7ZxyWQ9Tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5EKxe12Mplodzop8FSWH9+91kt1Gscjg9+APlZPqFM=;
 b=DkzUZWeLqb1Qm977j8PFrae6R4dLlmKKP0uayubaKLqXlL7b/1KBQ6YAIv/UdOy1tPAedialLloTTaZf4FygoWFwaoTJbbOJJg7rswkZcnpQaOhKhwgSYTy3dLLcATF3q3j4DHPprlnHbBNay6o3NMFyYwrJTsxVSEsL/LPgaMc=
Received: from SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:36:02 +0000
Received: from SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4]) by SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4%2]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 06:36:01 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Recall: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Topic: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Index: AQHcXQyZlmlPDNUTzE+P8IE4P3m4Rw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 24 Nov 2025 06:36:01 +0000
Message-ID: <SA1PR12MB85985804A49827C95678A15AF8D0A@SA1PR12MB8598.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-traffictypediagnostic: SA1PR12MB8598:EE_|MW4PR12MB6705:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffbf822-45c9-46e0-6d8c-08de2b23bc02
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?0yHY7YXMtxTZnveO21YVuIoWfX4blaLHvLseRa/aTvaUnM1zNMhPlIPSlq7L?=
 =?us-ascii?Q?bLX1P0VxpZBkbk+Etxu1qF17awgerP7qd3Q6IeKCWl60Wg4C2yBb7n1XQkhi?=
 =?us-ascii?Q?0GhQfZrZKi/HgH8Ds3NH9QkFWIoktFBC6+KUOq4YugO+t9fn9stbZGqBLkbl?=
 =?us-ascii?Q?mn1IbdP7tyRTeVlIhvVoTPwi7pPn7iF38Hq5/GEsCCej7sGnJJmmwlZiDgZi?=
 =?us-ascii?Q?RBupTIU7SIrqbVPKD+pTEY6RRth5XYbfiXm9WL4u3VgQ2Y8V+TKVVGhafvjd?=
 =?us-ascii?Q?s3cH7PfjUBRAar/rnRttdm4tyujXBjzCTRzHMpvL5zaVQ2jWU/PtIsgF+scp?=
 =?us-ascii?Q?LkPTLpyOTRmsRfkbTqARu6FsIWxk/Ry39jAU7kr7Tsqey1+oPYF7wsoB0zAV?=
 =?us-ascii?Q?1Y5v3cZortQGuKnJY8fQh6zEjtOAvwq0TdFKxcpSbr2f7plKB/IGdfz77NuC?=
 =?us-ascii?Q?LB0ug9TdpyZXHUlR7tpEMPD7k4IBL9t7KkNYXxEf5snlsRrA+SRF9LHa0WGY?=
 =?us-ascii?Q?9qk1F9unbSxUHnX1t6s7EnifiIbJe0u1STneKKaBe0vlP/laydpZFe7GABIM?=
 =?us-ascii?Q?I2ex+ldSHBRvZD3P1fGXYXFCjzjAxjQx0Pqg3cXXhRR9drpCKE//SgEVBrY1?=
 =?us-ascii?Q?m4U5FEQtfRfGd2PmSG/rypbSwQ+kWtbeUxl7e0kQ4cWoGAgrBceAcFQSvia7?=
 =?us-ascii?Q?0C27W/WL3utKdnORDNsehLOgaBVgeWb+Rzay9L2yHqGykvAi6WkvlpqiQakU?=
 =?us-ascii?Q?z1Qm61FBZDNr6zpisSLUpqYsewIjIP4AQFfxxKcS81tQufb/gYfVjpRHToDj?=
 =?us-ascii?Q?b1N1o4yWuNZ+PfQXHtEYTjErvV2mOHSRxScTLzyO4Ht+GQ8fQ9Ln4BTvDY10?=
 =?us-ascii?Q?sCTM6SxJjDIKy/UtPvBb7XD3EuLOIwG9WvI6AZPrHFCdTyADgxK9gAwmHZ/f?=
 =?us-ascii?Q?fxmFx6nB9ztdbuSEx0292nZpetqF/SCV3QuWJs/hGngxy1OcmCC/8RxmAvgp?=
 =?us-ascii?Q?7XdApaNoqt4u3NSk1h2NHNp7R3Z7suQDGtNzUW/0Qs3CR8cEo8X/8NuSmeKF?=
 =?us-ascii?Q?7bhrv6C6gx9Qiq8/+zLjwio7OeEcsT1qWgSar82Ikrqg9B5z+pEY4FMBc7x0?=
 =?us-ascii?Q?GPg3FQGvk+mnNiFPCeYwixII09NNFD+Y4pheehUffdmF6AeM2g62begq7Hol?=
 =?us-ascii?Q?DJrzYGO36/X6RxyVp9SaQvwnBf/h/hk9rlWJSwcPuIecE2qDTVn7cPCwVO/v?=
 =?us-ascii?Q?ScLc8zTyKWLldetVN8Rp3wXVy5mhAWny88DUjMj8UFa6YqgKXIm8IT7IMSF6?=
 =?us-ascii?Q?Ly/eU/l8BV7tZDcRfEFr/katiKsE4mHkyHaZaisYZgtHFzNphGcYhfUErhEL?=
 =?us-ascii?Q?SOn2GWmZWsXab568lv5ojoE3e4jQTgTf6BJQEmBe7M/csgGiv+jddEOhEwTZ?=
 =?us-ascii?Q?l1fBQSrqcPSzdeJ1z5XZ0K1pT5ph/mAqEgHKbfCaGfJv0qe+MRkNWHlVsbi9?=
 =?us-ascii?Q?URAtL9Vs+IEE1mavweXRCEtMcr+9fEqvUfYn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tREVfvA/cJ9B4tenhe1YNtZYHGvB/5WdPXcm/1bKAXjIyLAUi8EUeK8iNIeI?=
 =?us-ascii?Q?ZDOzC60AWkDUSxw6iu5ILRuBMaj8CJucMHFeU4CD7xO7TtuDxU2qJvpoTUvq?=
 =?us-ascii?Q?ISg/DNJqxYwEYBrGjFMON2vA2OgqbTTHBjOYE3LW6wgevxg2c9d/JvshH2we?=
 =?us-ascii?Q?vGS807OqRHMSnILY7f8OtyqEMlZHWimEK2/SidA08eXkOkQlh3M95Nvu7gVI?=
 =?us-ascii?Q?uFU366oeKRLC9bPx75FrojogrxKx8LH5qZ3WIsjAAycZ4A44Imp77o724A7w?=
 =?us-ascii?Q?ErwJVQC2noTvdVZbx7mZXY9uBFvBUKW94AS5JUBlAL0n6UZtafCLk183FiAd?=
 =?us-ascii?Q?A3DA1gvnGluD9CScdcTnLDozSp1SsD1aKkVSqzACG4eRIu7MTMatKrtUGFjT?=
 =?us-ascii?Q?lY0WdMOsvqsNA1/popHAvmXiMA/z6TEkIJjRIn/Gx2MBrkxP09SJhEdyJAWi?=
 =?us-ascii?Q?F2883jX+Z5J04nuwEdP7CsJouJFS2LmFuhUjMjAXIl5IuSg/tKtV6jtudQHT?=
 =?us-ascii?Q?4kEo6X6FANxuDJNcwnCFGlJedyel2DQIvK9PvGgEWL2pl/5ZFV0UqPaeMfMr?=
 =?us-ascii?Q?kpf88coSDbnA/6i3bCu+wZbvvj3nQny7Mf9+sjaLU0ddAKPCyv61zkKjgoj3?=
 =?us-ascii?Q?rdESpn0rthRhTT8jwjKFnUB7nbKX5ezaiKuhqBoC+xyAt7kJlEpzTMSjt5lv?=
 =?us-ascii?Q?z+lZS6B60DegTuqYX20RlBo+OisE+E2mnSeqF+jJf3zs4VLU21z7lqxiN4w3?=
 =?us-ascii?Q?eTgm+OAb9GR65JzF4pIauA0/aTqSmtPazTcFkqG0oXVSbOkGpYP+sLjfdqEJ?=
 =?us-ascii?Q?xgsYCVDOHrF53R7vv+t0bMuMf4z+n58oNW85Xtk2Pi6ii7Y7g7t+y1CnjooZ?=
 =?us-ascii?Q?n140e/asirM6CjYwTOz2nPlHSYWsQJVWEDJ3rsk1sPpvaw1ZFGvVRlpzt96z?=
 =?us-ascii?Q?0QRqE7URovh6E8gJ/NbKfUnYkv8r6xx+nwZAcxCSUr2ApcTDfb5X3gCGGgxe?=
 =?us-ascii?Q?UkOZ6iU1tXVMu6RyGR/uEJ5yA92hmqZmCzHGiBXWyuu3els7ZJyZLbF8G4rP?=
 =?us-ascii?Q?EQQYF5TLFkE8ppam1CXX5Eij2ThBdAbrZylM19lXJOIcrUxxC20hDMTz+dSy?=
 =?us-ascii?Q?Nyd8qE4jxDKJx4Xo7IbDeBPLzsGnZGTuxu+fQjqjnSfemLxhn73tkc21wOVa?=
 =?us-ascii?Q?KPvsRD8b/M0d8R6oLPCJVuhSDDJl2yAEV+wbk1PkjBhoe8PL43MDytUGInaQ?=
 =?us-ascii?Q?qHRU8Mkk0FHfOQVx7hVoMvkMfv64Ge+C0+vLwMkZJOyMzAuXRkby8M9REXTE?=
 =?us-ascii?Q?ZK59tJ49A0fwYGXu4nal0z3kXQzxE0M6NtC14ig8c4bKXwpkaalpmS7OWitH?=
 =?us-ascii?Q?yUX9LXne+dYpmIxwLLx/ruGiHo7FVk0hJvffVIkzPmqeB86g7dyLJzTdLXFF?=
 =?us-ascii?Q?MB+CKddq6R9L8HoH5LiqJJX/Udq0SIG+k05OKjDkB5IwxGEL2Q357PevsM4C?=
 =?us-ascii?Q?iHMzzP9IlbpsdT83D4wtNtDy8cWA5IG2DPlL+lp22J+5uirPkO5c8QKeGfuS?=
 =?us-ascii?Q?c8ObniRPJ7LKsBv4tCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffbf822-45c9-46e0-6d8c-08de2b23bc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 06:36:01.1180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tEtUdPRiZtcVl1rYByX2c6ZRPmywbAaxrgimzc+2v3mJSGjpFCeSHIWdpEV5XFHrJPrqBElSRFLPVHP0Wds8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=PengJu.Zhou@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Zhou, Peng Ju would like to recall the message, "[PATCH] hw/i386/kvm: Preve=
nt guest monotonic clock jump after live migration".=

