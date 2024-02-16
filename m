Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D67BC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1ue-0005oV-To; Fri, 16 Feb 2024 12:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1ud-0005o8-4S
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1ua-0004V0-Ua
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:10 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41GFCiUR025269; Fri, 16 Feb 2024 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=Q8fxDmeBKxN+j0qNMfemoGd7goH261IPSKeAHVhlppY=; b=PM
 0QL4wv2PmVPaXuhkQ3/S9P0LI+W1UpW5L39cAmgKtIzJr/FFNSE0ZFo+0Py7mo+C
 ox9e7arpnLFUnla8z3phy1sqi1rvtFVx9kViQVhgwioFOWQnDQcdD3WFM62rdiJQ
 ita6rcqt7+Xcxc8tamG0bewJ+pMNh3okDMhv5jgtSBVw8Ah/DVOr45EZb2y68+dQ
 paLRYTM4ci77QeLpZDHDjUI638mmgw3f5e7ifUCyTwH/t0W6cbYXOVUZSFljCHn4
 VofcUyFeGVySMsnuQdhH5XIDzvITTy8qV3uVbJy7kbQPUDP0dh6i654F4VjtAs2b
 Pm03Bq8RzT+tWdk+gR4Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9qbc2j9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 17:22:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+xtLkVx7yv4hldtz/gSxc/XiwMv/3BQDLRoSygxFEKVM9tanPGYN62xcZgDuz6CvEMHWZLJzHqiEsmaESuDa8nYu/en9UcyTZaH20286aCnOHc9Ra9UDtoY6Z9dDm0rnEuw7CQ4WlLWJBJiLVWBwT1uG3L9PaeCuRfAXyr/vZYhz8vNv1PDdfgETzNe/96faVkNMOJV2nh47PZFExTH+89mCYwYseIe93iP2mr6RrvcFmcOplmNVnjYwxwqzZHZwFhqMhQpco85fujdSecAAccMv5aLLcJHx1rg0oYTiO/NCiZuAGMxfHLpVnvQy5ofDneD1mjgHNGd6nyxoFdOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8fxDmeBKxN+j0qNMfemoGd7goH261IPSKeAHVhlppY=;
 b=aW249/Dxsc1Vy7hQ6ZdzKqLMHKKUMF9DnuvuBwsUK9yt7ERpGzKV1iX3Y/6/oaXDtzUl78u+kXrftetvcVn0uLhPb8qKeNzVdbjC5Ms6LjtvG4og7juUFuTsEjKYTFij0D02z0MBvDMWENeNCTozttEznQnTWGT+xmFCNZvIDiUkrBCR6FJ/09R/Bz+bw4BG2WyYzHTS91syb5/Qc7LSAoEf6C1i+BmcBzP65S41HdfhcTFQ4sHRIbED2QIfGwTq6I/34TopLDzsC/SmqHK81j2Vmamyu0Aakp1+46+OVEOzd4KlSf9+rgcXHu186ddD3fIbaQD1+p0SqgUpM3LY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by DM4PR02MB9094.namprd02.prod.outlook.com
 (2603:10b6:8:112::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 17:21:57 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:21:57 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v3 1/3] Hexagon (target/hexagon) Pass P0 explicitly to
 helpers that need it
Thread-Topic: [PATCH v3 1/3] Hexagon (target/hexagon) Pass P0 explicitly to
 helpers that need it
Thread-Index: AQHaXv4i+HfiY1C/q0id5B1RYJjs5rENOzMg
Date: Fri, 16 Feb 2024 17:21:57 +0000
Message-ID: <CH3PR02MB10247CECBDA5EE67DCE0759D8B84C2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
 <20240214042726.19290-2-ltaylorsimpson@gmail.com>
In-Reply-To: <20240214042726.19290-2-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|DM4PR02MB9094:EE_
x-ms-office365-filtering-correlation-id: b9d1508a-9d7d-4c96-5ea4-08dc2f13c728
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+tyY1AW9I301J+bw4X1vNnd0xdZHlaXcqEX+OpjG+Xk7lJlyu0RotfhgzeAimGnsDFKtw4vVsQovHkX8aqWP4d0SX27ahV41n7SS8Tf8Q998jNslMyrwkoEKMPo6VYPgb2IP5JMnruuwQDAnx+3kKZqaxg9zcGhrQ/fhseX6p/M0X60a1oIY1lswPgwNDv3l/eiztw8ell72N+syKg3nIRH18AivsNDO/k7saito8hbbYm2iHBavpQ+gQiz7L+XapABR3ZKRuLDJ1v8SYkMSTtkYbEPtSrYhJuSFyGMqTqKO9/1flGQ0fBgzr+Saa0Pl6RlihbwEsmuekNOCu3sFXJu6XdoJWzxLOWupLzKzSn3EYMsI+Z+f6CasrWAgcAmu1Ytl3J4e3Pp5RQBwI2AWLM72jInzIa76MbwIUemdn87kiTth9Frf1+jQIZU9iYGlYzgldh5BRbRoIwStUoMXlab621dCl0rNT4x951mI8X6m7md/kLHM2xx1vrT9y9JSAmB4YFdK9gK6QsbY0ChtmTU0qmd2zFeAwdt6umXZrXlvvzyO0FN/NdgaRnZBnrZ7hGsnFFgi0P7iiZ9He9U78YHlwJg01bfKmzXu7k/Yt2MvApQ0iJGC8mKJr3mRre9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(33656002)(55016003)(66556008)(66446008)(71200400001)(52536014)(66476007)(2906002)(4326008)(76116006)(8936002)(122000001)(83380400001)(38100700002)(66946007)(5660300002)(8676002)(64756008)(110136005)(41300700001)(38070700009)(9686003)(316002)(54906003)(6506007)(478600001)(26005)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2NLWHMxTEtIcThQRUI2NlFNNGtTcGN5ZmwyTVA3NWphdDAxUTM2T3o3TW5o?=
 =?utf-8?B?bXRmQ1pVOUtDUlNLR3Y5OGFMZVRuQkE4V25JbnpINEZMb0VFZ21ibkIzYzMv?=
 =?utf-8?B?YzE3T2hPRlZUZ1ZuMXdZWlgxcldBUkpZQXRaWnZSNDhkVnJyYTJJUVRqR1Fr?=
 =?utf-8?B?eC9BblBjSU1hNlZYZHNVODVHdnE2SEh6L3hrWExQZDhsaTdSRzE1YVU2QWJi?=
 =?utf-8?B?MnBaTWl5YzZvS3BrRldLQnhvYUIxNmVZY2h2TFcyWEQxOG0vMFBaVEJ2bS9C?=
 =?utf-8?B?cEs0Sy9adDduSXVFYXZBdzJVeUFDaXBrTzNTbUhWR0w1VVlrTXBPRUdrTWlN?=
 =?utf-8?B?VitHbmtOOVRSSEJYdEJTMGs2Zi9qQzRJQWxHOEx3ZjhRZ1dJK28wOGMrZnZ1?=
 =?utf-8?B?cndjdHNBWWdwcThrVVpzdnY3c0lRbnlLOVp3TFVMTVo1TnEwQUo4cDVtVGFZ?=
 =?utf-8?B?NU4rYlJ6ckU4SUxRajBsN2Vtc1J5MmsxY0M4UEF4MUpHRWMxUHhITVFqWHIx?=
 =?utf-8?B?VjVrN1gyKzErKy82Qm5Zb3A2Mlk5UFRBaXltZnBqZkEvR2ROdTJJMjFWQ015?=
 =?utf-8?B?eWRtMHhrSkkwN2Q4WTZSeVVpbFhycHdRa2szaG9vSDZuaTFHUnR5YVk5TEp3?=
 =?utf-8?B?OUNpeXQyckx0ZCtpc3pIdENxb282eS9BMlFJWnFHVWcvcGlqenRuam9lNGVn?=
 =?utf-8?B?WU1xejdIc3BONVh4WlpRZHJjSHVQLzN0Nng2bDhlMVl5U3pHU2VJMTFoR0FJ?=
 =?utf-8?B?UlZMVlRGU2JaVzl0K3I3WUpZNkE1elYvYWpHZU9tazVOQkl0bzdpUzFvNi9k?=
 =?utf-8?B?MDdCdytHRGx3d0p5UEl4TmZmSDUwL2F2cU9sd20wTmZhbUJNZDNCRmpGWEVz?=
 =?utf-8?B?dzNhbjNiOEw2aGNGZ3ZBaFRaWk11RE1SSWZtNVNNVThqVVRlNktDWUwxRVFG?=
 =?utf-8?B?K0RxRCtmRzRsS2NENGtuUmR3WTREMHFJc1dQUW5Ra2JpM3NIYmV5dEVlODdN?=
 =?utf-8?B?a3dDOVQybzJhYmc1NTNuWXlNOHpCdng2NWdSOUkxVnp4b2xXTFpwY1NwMGVC?=
 =?utf-8?B?dk5TcDVTOERlUW9oQ3MveVhtOU5HY1kveFE0RFVQUWM4ajVpR0VORHduVTlX?=
 =?utf-8?B?amJEMFA0OThmQ0tJMWJlWlNwaU1QZVlqd3BZRllhbHE5bmtSQzZqejVNOFgx?=
 =?utf-8?B?Q3VWaG9JL2ZwaWdEODErY1J2d1dtNzhoZmt6ZEtoUlYzWlNwVFdrdG9CSmhY?=
 =?utf-8?B?TkxobUs2R1dBQkdjSmJUUFdLVDlyY3VGV0xndEV6MVhMZXJiRHlyZGJyNjB2?=
 =?utf-8?B?eldWeTRvUW9lSVJRNWI5N0hoSzFOSG1jVFJpYXI3QXZjSm04L0Fzc3VEQnJx?=
 =?utf-8?B?VGdrZ3IvQ0o3UVdyaUw1SUpLYUJzRkRBZ0xqc3haeEl6M2tRc1ZiOUVST2Na?=
 =?utf-8?B?cnd6dnNQNmw2S21GWFVhNURhRUtlQlp4YkovOFpIdlRJN2ZjcGJUSGFhNito?=
 =?utf-8?B?YVVIdk1HWk95ZUZiekRJdy94NXc3dG53bkxhMktyM1ZRblVkNFJhcVYrdHg4?=
 =?utf-8?B?ZWEvWHdvUnFRaE9rclE5THVDeURCa2ttbmF0ZGdEZks4RlZmNE5TNGhSa1ZG?=
 =?utf-8?B?MldkdjRHNi9mTjFNVmVNOWNNR2xGa3lqc2lKTUtTREM4bGZmNFhITk5KOUlz?=
 =?utf-8?B?cVVRTHB4SVI4MG5Ma0t4bXJCOHluZWJTdDhOZU05dVRaejhWV2N6YzFvNmo0?=
 =?utf-8?B?dld4SmhhcEpFM1UzcEh1U1hrVFJDb2lJWmYyd2RSWEhkYmdVWCt6aDNVc1Y4?=
 =?utf-8?B?ZGJWMlVRVTA5ZnV0K1BwRnl5UGdGWi8rNDRuMkRZMVJQVWZqa2pkRVRzYmFL?=
 =?utf-8?B?K0g4SlIzS251TXhZUnhCYmFyUUVDMDEvWmEzdnZOVk5ZTThEWFMyMFVyZ080?=
 =?utf-8?B?NXl3S2FuSTkxaVZub1lPZThWWERxbHdSU0E4SWNwRkhjckIxTFhDQ2k5bGRJ?=
 =?utf-8?B?R3Zkb05PYmlLTFIxOTcwZEQyL290aDJ6NC95MUl0TDRFUm9zNFhQVGlCejQ1?=
 =?utf-8?B?eUM5YXpIbVk2S3Y5OTJGT3R4V2NUcnF6YitNUjNncHY5RjFBRWJJUXdhUTlT?=
 =?utf-8?Q?EyqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FncesOk0MhT8JAvwGPgElvFauG9XbvaeltFayY0bi24YzxDy2zIKpyAgaQ3+DOFRZgAJWtztoaNvp3QMuTtGK3MscCbDxOxEibnO/+l2NrL7OEvUaayKcA8V+mUDXOPVkUIxhILt7Do5bA7sEqyQ+at6EBGlSJ5H2fZLU6Szxn4tBEsCPhiFsFqQbrvIA2U9WFxLFvDsfshKmwCo3FZ72y+tNs2EuTXdy6MHRgszOSTCqS4W4IdksEssJjKDVh4xOmN85EoQI6m9U9O703n8nqwCTcKS7TZhRR2QvOq3IghXh3rj/EKEXny25vW1lHMIA94BBO/MTyzDIBEXzldLz++QPGNz2R8HsmJw55g/bWtjgF7tAvb+81mfBeginFEx3Xx9jcPs7D8DO00CBHS6/fOWLo1bclnbKQ5BQFUfGSyeH9CXQhVXF8zFNkUITUUEaYYfWVKhs0a0TCZ13jO2B7KT367BOfMqDYsMZFL38mhX+JimrKoTMFdZMWq356iwuSXJrsnNaqWPJmexGXK+iyyQUlvx10coU3XkY5Z4+EoXHLNp4iTR4LjdzqUEzOeTZ76fXcT76OQzhFjGqHSyUCbrp1gqXkP0qoTcIYdTBNetL155gpG0CiEV8qF94zZa
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d1508a-9d7d-4c96-5ea4-08dc2f13c728
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 17:21:57.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M93Gsbr3gNI+rg5zGc8qq2okMfOFAfcpMIVye/JPLjjwxYSYrHuB8y+xXkC/3gHh+LymIViixK8zvucxp+NpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9094
X-Proofpoint-GUID: nLTbSs74lhj6PGA3mHNWXGWKcRXWLaIw
X-Proofpoint-ORIG-GUID: nLTbSs74lhj6PGA3mHNWXGWKcRXWLaIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_17,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=474
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160138
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTMs
IDIwMjQgMTA6MjcgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4g
Q2FpbiA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxx
dWljX21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5j
b20+OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJl
di5uZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjMgMS8zXSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUGFzcyBQMCBleHBsaWNpdGx5
IHRvIGhlbHBlcnMNCj4gdGhhdCBuZWVkIGl0DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBh
bnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+
IFJhdGhlciB0aGFuIHJlYWRpbmcgUDAgZnJvbSB0aGUgZW52LCBwYXNzIGl0IGV4cGxpY2l0bHkN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPg0KPiBU
ZXN0ZWQtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+DQo+IC0tLQ0KDQpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCj4gIHRhcmdldC9oZXhhZ29u
L21hY3Jvcy5oICAgICAgfCAgNCArKy0tDQo+ICB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
IHwgMTIgKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9z
LmggYi90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiBpbmRleCAxMzc2ZDZjY2MxLi5hZWRjODYz
ZmFiIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiArKysgYi90YXJn
ZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gIC8qDQo+IC0gKiAgQ29w
eXJpZ2h0KGMpIDIwMTktMjAyMyBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwg
UmlnaHRzDQo+IFJlc2VydmVkLg0KPiArICogIENvcHlyaWdodChjKSAyMDE5LTIwMjQgUXVhbGNv
bW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cw0KPiBSZXNlcnZlZC4NCj4gICAq
DQo+ICAgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkNCj4gICAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPiBAQCAtMzU4LDcgKzM1
OCw3IEBAIHN0YXRpYyBpbmxpbmUgVENHdiBnZW5fcmVhZF9pcmVnKFRDR3YgcmVzdWx0LCBUQ0d2
IHZhbCwNCj4gaW50IHNoaWZ0KQ0KPiAgI2VuZGlmDQo+ICAjZGVmaW5lIGZSRUFEX1BDKCkgKFBD
KQ0KPiANCj4gLSNkZWZpbmUgZlJFQURfUDAoKSAoZW52LT5wcmVkWzBdKQ0KPiArI2RlZmluZSBm
UkVBRF9QMCgpIChQMCkNCj4gDQo+ICAjZGVmaW5lIGZDSEVDS19QQ0FMSUdOKEEpDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29u
L2hleF9jb21tb24ucHkNCj4gaW5kZXggMTk1NjIwYzdlYy4uMTRkY2YyNjFiNCAxMDA3NTUNCj4g
LS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQ0KPiArKysgYi90YXJnZXQvaGV4YWdv
bi9oZXhfY29tbW9uLnB5DQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgIyEvdXNyL2Jpbi9lbnYgcHl0
aG9uMw0KPiANCj4gICMjDQo+IC0jIyAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMyBRdWFsY29tbSBJ
bm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzDQo+IFJlc2VydmVkLg0KPiArIyMgIENv
cHlyaWdodChjKSAyMDE5LTIwMjQgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxs
IFJpZ2h0cw0KPiBSZXNlcnZlZC4NCj4gICMjDQo+ICAjIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4gICMjICBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1
Ymxpc2hlZCBieQ0KPiBAQCAtMTk3LDYgKzE5NywxMCBAQCBkZWYgZ2V0X3RhZ2ltbXMoKToNCj4g
ICAgICByZXR1cm4gZGljdCh6aXAodGFncywgbGlzdChtYXAoY29tcHV0ZV90YWdfaW1tZWRpYXRl
cywgdGFncykpKSkNCj4gDQo+IA0KPiArZGVmIG5lZWRfcDAodGFnKToNCj4gKyAgICByZXR1cm4g
IkFfSU1QTElDSVRfUkVBRFNfUDAiIGluIGF0dHJpYmRpY3RbdGFnXQ0KPiArDQo+ICsNCj4gIGRl
ZiBuZWVkX3Nsb3QodGFnKToNCj4gICAgICBpZiAoDQo+ICAgICAgICAgICJBX0NWSV9TQ0FUVEVS
IiBub3QgaW4gYXR0cmliZGljdFt0YWddDQo+IEBAIC0xMTE4LDYgKzExMjIsMTIgQEAgZGVmIGhl
bHBlcl9hcmdzKHRhZywgcmVncywgaW1tcyk6DQo+ICAgICAgICAgICAgICAidGNnX2NvbnN0YW50
X3RsKGN0eC0+bmV4dF9QQykiLA0KPiAgICAgICAgICAgICAgInRhcmdldF91bG9uZyBuZXh0X1BD
Ig0KPiAgICAgICAgICApKQ0KPiArICAgIGlmIG5lZWRfcDAodGFnKToNCj4gKyAgICAgICAgYXJn
cy5hcHBlbmQoSGVscGVyQXJnKA0KPiArICAgICAgICAgICAgImkzMiIsDQo+ICsgICAgICAgICAg
ICAiaGV4X3ByZWRbMF0iLA0KPiArICAgICAgICAgICAgInVpbnQzMl90IFAwIg0KPiArICAgICAg
ICApKQ0KPiAgICAgIGlmIG5lZWRfc2xvdCh0YWcpOg0KPiAgICAgICAgICBhcmdzLmFwcGVuZChI
ZWxwZXJBcmcoDQo+ICAgICAgICAgICAgICAiaTMyIiwNCj4gLS0NCj4gMi4zNC4xDQoNCg==

