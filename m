Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC1AC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zQA-0002Gl-Qx; Thu, 24 Apr 2025 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7zQ8-0002GO-TV; Thu, 24 Apr 2025 12:27:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7zQ2-0001Ez-8L; Thu, 24 Apr 2025 12:27:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8Sf3O024258;
 Thu, 24 Apr 2025 09:27:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FkX3cjAfYe4JVwpQwdGSM7pdPWRe3vMQNSeoygQlx
 P4=; b=OOQXlIR5PEgjZNzFl/SH1hr2pRMlhB5LzbP5mF9H5gSOVJXa2o84pczLH
 ge9iE6t3hlAZVtb8RQYpAY/mNYOPIPJmOc3Qips1se0qvemPlpub/iOXGhn84V4X
 Zdj41y7JU7dG7CD0PJL+eX4hynQ7QRrbLwPqDb8mGXJG3c0oag6821xK79UgIY2b
 5qmOs+NwgAfngWHTBXmC8tgYuUls4taz65cvUEpXm02qwF4IzHyrSuiV1JKNRcnu
 gMqu8Dhpzb5jbvomDykjxDUEVyBfykRg7qusrCkwK2IAwXC0c4UubvyLCICXJJoy
 gdKAIHncS0HsIwTDlGJdqqVj3OJJA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvw62g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 09:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehh4oxPJVnjOus/nNZG/H4Kkg+gFhN5G3rJhBNW2TC9zlnt6NyZGX6OYjOFF3cqAIjz0s/5dhLDjkRDFiqHUsSg4svcwZJ0YeAUC1KJrB7C8NcaKR860ISs0Y0cN1tPjI4ivGbEwzOfXSQcg9HEIvJhBt0bna95zO0LN8uRaFf8ThBR6YUe+81pfaf3aaNd5KRF06MG6JpCGtzVgm6tv0wAuWssFraWkEm4/eAQW1p8aqME3SYorUfsmcAETIHUkkXPoYGDzKcxkFBrzTNqAwveFNvy3EblAotmLfGEY6/UhhKkPFOF9iCfZezCAxHj0NhiBu6vm9ZoT1PukkMWITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSSRE2gR+ZMJsdoJ3ycL62A2pZa7EhUH/I2QJyCmIOQ=;
 b=ki+FWnTnwM0JbSztZ1Sjc85WiOsdzcbFyVFV6MrtkN+AQfnj17gWuqRQ9LuBI0ta6pyaNNKYfcoZeiwt0+bevU4P4OwUXp4oZ0+3skS5Pk1HR4jWXxwrhipT5c9W1Hu2WUlgiXt16lbl2q0EKUx9Bsoh9mSIj0dOHPAclC0q7fiSv6pT3HUPxRAy3lEDNocYIbeQ/7U3QQEwghyJDd7Mixh7a9Czdxs/2S+bLzVumhBqYgwr4eOjXBhNWfrhXC7gpRmU0PXTRJ6pazqQIvLO2ZNqdUBR3tte7IiGujQpqTnYV7dvXWNh3ZQowHLuhv7j6tcN9WNtoR9anPpxN/uq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSSRE2gR+ZMJsdoJ3ycL62A2pZa7EhUH/I2QJyCmIOQ=;
 b=g7Ou+03VO5Ae055e4DVpq9Q97zgs6jYIB6YjpJatvGoVJS1fcTuUC3pstO2OWk0Iu3ZPZ9zDujfdGf1jr6Tyg/vImyKj0h5LwBr6uZWLgOeExhzBcpK3N1JGKiGVGqr7pJIPL7a+go3OVk5kRlcBGEj+rCNHqdnT98UW9grDQxMYmkrB0Opgt8Z05sKWcTtuKWbtiu3WJj+uxRq2E4eSb6VonWRo5tmQmrLYZIGSXo3LkRQ55KZ4DBf+l5ecm1PppF4QJ7fkUbbCuIlweSNcL6eApIq9NLGuS9CVPRUy0kNSkVtZEOKK4a2V8B3CH+BJLdtY9KRnaDr6sVXVdhQHMA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9848.namprd02.prod.outlook.com (2603:10b6:806:38a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 16:26:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Thu, 24 Apr 2025
 16:26:57 +0000
Date: Thu, 24 Apr 2025 17:26:48 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 12/14] vfio: add region info cache
Message-ID: <aApmSCNUQsDxh9hX@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
 <1eb29556-a03d-48c2-91d0-b4934b226e51@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb29556-a03d-48c2-91d0-b4934b226e51@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: ef506778-d568-4840-3171-08dd834cd4bd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rkDpwnbrfYNPSqPk1W8NrnmVnZrI2ijTW/O1f26Vm1MwAS7PihU/pem68p?=
 =?iso-8859-1?Q?iPaF4uQXd3cOoqgJroxRJ4qNPbU5awvQ6uBfolqs9E95UjuRKlCRePtsPk?=
 =?iso-8859-1?Q?PrmrS/h//x9WYNv8hztapFd0k3oOkO9R9Tcz3nCXn4ZuRy+UfZF19G1L0I?=
 =?iso-8859-1?Q?u8/q6NlZ5NeggX1fp45SoMBQpmhpGA7BwfS3B2eyC/s8gz0gWsb9Fq6o/E?=
 =?iso-8859-1?Q?s/K9Sei9Mf1ly8vrFBK1y9BhPnmFZ00QYuBDECmDYpkeBVgWIplHSoGbsd?=
 =?iso-8859-1?Q?ArJngrW9GlP/zRJzy8CCIgJNP7jwPipXnnteZnCUd1WGqClIiLG66+AksU?=
 =?iso-8859-1?Q?Ef4wft8R4qU7Hgz+bUS1yUjjGC27gstzZbwcskKM/fRkbjbEwbvdbe2IAB?=
 =?iso-8859-1?Q?cZjIp/R5NEO24NAbJind7PplBo0z2/Jb8RwKyEDi5wdUw9I5Fe1sUoYYSy?=
 =?iso-8859-1?Q?FHhMVApigqsDMWPV3vqbqOaIG6NlrEzQehzOT3oTmEi7uin3vy6gMqdehT?=
 =?iso-8859-1?Q?aVoafo8jbO09kKLSX74/d0mCjUlWOdmpFwzffj7x/ChzQGZi6m8TxmCEP0?=
 =?iso-8859-1?Q?kpiQmxru8uSE2MEFIozT7TRtaKW8HHuSTGkMUvDmr082bDUlhsC0Wzy+et?=
 =?iso-8859-1?Q?qyFcFN/t3uUot7iw7Wld3T+cCiYMUv8wIriCf4W27Kk2RsCtq4AlPA3jtW?=
 =?iso-8859-1?Q?68UcdPeQCABglxT9QplpNmXdkERwhOjRXg1tct5jl4H0olVBMUWuc7pYf5?=
 =?iso-8859-1?Q?HeDGbFpIsiyXE/caJ984LEaTzlgGDf4vhOy1M2RSB1CoPp0rM+czBODGLc?=
 =?iso-8859-1?Q?BOpAXz36c4yDqjp5RdohpGtJBkf5ifaoqq+KLZs+LHj0cSCrNKqndlVyE7?=
 =?iso-8859-1?Q?1UiP7jvUWOVQdCYbWSo6SJEPDjvh0ACtTT2Rt194cARnnLolo7o3SfvH88?=
 =?iso-8859-1?Q?cse+GwCj3Ca+5B7KfVECEqxlvCKPX+aijSQmBHRnDNEXrfNdbh5lTWrkYc?=
 =?iso-8859-1?Q?bD6WdcrZz508q4fapCGGhlx/t+0o5Wp7mOtdPd6Gm4IqDHJ3dv74XASmw0?=
 =?iso-8859-1?Q?M2q+FZ6DCh7+8N8EHmx65iRSEwusilvgstFBoRrxsWIY5/tsloBvMJObk5?=
 =?iso-8859-1?Q?7puZJqF+JCYCrKSovItWpvt9XN+E0JQoIxUWHnaz1fY7in8Ta7iSb7zdUx?=
 =?iso-8859-1?Q?LzbWB1riP15QQxIh0AbHe6QCQ+lIhojZdnARrkeBmhq8aJTY3CsdQY0dfb?=
 =?iso-8859-1?Q?btmktKYZcbRUDfHjZizfjssj/MerBO0uwV8VGZwTu1/AP6nPKFhFMIOg0z?=
 =?iso-8859-1?Q?Sw3PpQe32ADUwsuUyiou4+oHeSy5wVwsip/U3yrHj0UGJFOIY8lPWxWefD?=
 =?iso-8859-1?Q?ZdrZquZilL4TjoZEPyfCKLAMh6HBUI7i3xzsGImW2Mi1e9BcEXAx6kAZk4?=
 =?iso-8859-1?Q?bTm3yKbwxNyjGdifL6MvEaYli7XNmKuYobUfCiBokRaH6NkQBUY+pviONt?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AKGRF712lGg8NmZMsUShkOnlnDFulsdDNadwRevYajEmQ1+4VJJ2Z0tkHN?=
 =?iso-8859-1?Q?RqTaG/McXHQV+f40WY+w3nLYE1JAEa5Qi6oQzVry77jcdVlf9fiGiT8nBO?=
 =?iso-8859-1?Q?aLzN+7VXqHbwVMB6YG+jvZT5OUQ3RYt4A8h7eW9ZjSp7eRj2nPum4slHn6?=
 =?iso-8859-1?Q?UfM9MNAsqRuuexBpWO4MMGFL7rmlbJiMm99AZMq2bkwfc29jdsmUSWmrdt?=
 =?iso-8859-1?Q?WcU4MDE4fKjclB0XUkYdYz1kNZPX/iOf+x7fQ13n5fkuEQZ5Lg077Zb4cU?=
 =?iso-8859-1?Q?tLoJtS3wS4RKbEfOY3HHvgKQG4nejYthYqvlKPbt3/KH9f7SbXh9YIjUbi?=
 =?iso-8859-1?Q?nEvlA2NJcql2qLP/0l5jQ5SSNV50TWoV3iDYQ7Cbzxnm7joJYPRrfIEsQ6?=
 =?iso-8859-1?Q?wwSC4HH1yUoOL1m8b7BK/pospU8fVeWnzVk6/bb0r7Z2lOsIKLT0f6QDsQ?=
 =?iso-8859-1?Q?OkT7xan6AGGZ/TowhazAJLQSD4e9sKwgYo5L4P/nBPxRdCcMnZ5Ah0c+dI?=
 =?iso-8859-1?Q?sh0uKbYJjYKrCYt0j9cv3Is0H9bZz6v4Dt5fo3iIsbos0UNLSx8atT0XsO?=
 =?iso-8859-1?Q?IuVGhn2uO49xRIqKfjwYz/Nwar/E5et6Lc51DFLfVIgZOXxNh79fo8tRTN?=
 =?iso-8859-1?Q?VVhwjkgfhQoNgxHI3RIpWeA2Zl+nqnxdCPlWq+fTut7o84gtdlUTI6kYj+?=
 =?iso-8859-1?Q?uBP20ucnx/U8CLtCQ4kJG9fuuwxbIMJ//6PkQaSmroit9IOTdrEncPxOag?=
 =?iso-8859-1?Q?g1b2KifIbya6N6bouP3vkuxF5aTX3zj8HX0tfxok7do6xtcOvD5ONhBCLJ?=
 =?iso-8859-1?Q?7xoh+C7YFO7r8GAt2YNqFtlmjYC+PpiWJTzvR6XhNDEc9nDJ36p50PQKu3?=
 =?iso-8859-1?Q?/VhT72o/xWW9R+MsHSQWfOU+0c2ON+jIt+xJp8RpkgIQU54cm8XR1quwm7?=
 =?iso-8859-1?Q?GhPi6rp4kbTm60YdknyLgkNZpPSED8unf3TVdtRlp7VSKFhyfMazzlUeEs?=
 =?iso-8859-1?Q?1/Vh8WEllUkn865S0KTroa0l73sXb9lLgBk55ZgmeFP35x5jWVo+F/Jqjy?=
 =?iso-8859-1?Q?rI++W1IqCqQulG4zPXQ4ZmG+GEUHO8lWzrAD8ErKAzzjbp7YRD787LQRyi?=
 =?iso-8859-1?Q?l2XcI1cpkoBjFG3qvlnTVG/2AF2xmlGCRdzn/uAXZkUVqvYp7KXGcq40Ak?=
 =?iso-8859-1?Q?jf/4xoQLXd+iuUwbCOWuA8f1lGdjLvwMUSaEivr8puobh4UzTtTI+xIzuV?=
 =?iso-8859-1?Q?KqgBzW120s+Tgjva9t9aUBeWdv0yPBYwqp1GQllFVivZC4DzRIBnirQEBY?=
 =?iso-8859-1?Q?um89PpbOqbtcXUf2+Yk9PxccugaO2ZCkOxCMrhIc1Njg8U6agnvrnV7dYd?=
 =?iso-8859-1?Q?Fx9JKDpobnjvafhHos525K6QVU167CqGHujkdfOdF7XsIM6eSPUqOfNSkk?=
 =?iso-8859-1?Q?BJjnI9LzahRlSpjdvIneFyhXh1kBstBTjC8JC1uwkM51fmjiIRb6dd9kZT?=
 =?iso-8859-1?Q?CJxA77XQIt2WSLrxDkwjfZAcfrfgEQTtOdr/ozLavyFdtRLtN5OrzyEQFO?=
 =?iso-8859-1?Q?S2Wh6i8t1z+3QLIOwZeEgh7ZjsGcNglqYCdkn/txbsPMJXARooC2tnOeY6?=
 =?iso-8859-1?Q?2Q4ruh6dkCaPwdq1euIeSnSYjNw0B2uoHW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef506778-d568-4840-3171-08dd834cd4bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:26:56.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AitMUTnI1CPlV5iYeWmAszAN5TARJu2itQrdsATossrJpPpceH73sxUmZUU3b5h8aWBnbhusW2TOG3263l+09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9848
X-Proofpoint-GUID: 3awpVdPtTeKQzRQuNUtYSOJhFYFOF5lC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExMyBTYWx0ZWRfX4XJ9aSoz4vYt
 NAeOeqZhtdS+PscudQmHfYS5+s0cStQDIpNkwXiSENHHU3zb8OvbEVHJNJsbsMLCgDCJrauHgiu
 ExNGi/RlBGV/KKJV/GDey3Nq/+MX0V9r+INuAL2dfedVc42Ldy5v5TTyyjwBRPl5F8my8euRYnX
 tVVCvmigPXLdwMkQKiGwFJT/kNNteJT1uPiz85bUQMUFpP+sz1B6Ekrowz2JFlG08+Bv+i+XesF
 aV0BuAvwjU/aLLL21wPGG2myN9PxLTRbX8hoJAqlv5+NttvsOK+g6SPa8dR/mUWQAcftC4MzhwX
 kT1LXzNtbdNC7m/+0Xc9jenRCZpFlmwtYFEG8MIsQYQN77MilEQzQDY9Ci01WgdRxoGIZtZVBA1
 xVr8fmWuV6VOu7RsA4+UJ5KWE10jPtRtMGZC1Ji7uBJ+joYVfn8hxuFPl+2jyU+vaKiH+6ci
X-Authority-Analysis: v=2.4 cv=PNMP+eqC c=1 sm=1 tr=0 ts=680a6661 cx=c_pps
 a=iNWIl9VYHPL0lOopq5qx6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=PREYPQEfyG0RzPAIYnYA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 3awpVdPtTeKQzRQuNUtYSOJhFYFOF5lC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 06:08:21PM +0200, Cédric Le Goater wrote:

> On 4/9/25 15:48, John Levon wrote:
> > Instead of requesting region information on demand with
> > VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
> > necessary for performance for vfio-user, where this call becomes a
> > message over the control socket, so is of higher overhead than the
> > traditional path.
> > 
> > We will also need it to generalize region accesses, as that means we
> > can't use ->config_offset for configuration space accesses, but must
> > look up the region offset (if relevant) each time.
> 
> This change is an optimization for vfio-user. I would prefer to keep it
> for after enabling vfio-user.

It's not vfio-user specific. Just to clarify, you want this code:

   static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
                                   uint32_t size, void *data, bool post)
   {
      struct vfio_region_info *info = vbasedev->regions[index];
      int ret;
  
      ret = pwrite(vbasedev->fd, data, size, info->offset + off);
 
      return ret < 0 ? -errno : ret;
   }

to become:

  static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
                                  uint32_t size, void *data, bool post)
  {
          struct vfio_region_info info;

     ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &info);

     struct vfio_region_info *info = vbasedev->regions[index];
     int ret;
 
     ret = pwrite(vbasedev->fd, data, size, info->offset + off);

     return ret < 0 ? -errno : ret;
 }


i.e. every region read/write needs to look up info each time?

If not, what are you suggesting?

regards
john

