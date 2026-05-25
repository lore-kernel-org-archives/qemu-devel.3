Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81FACD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRa2A-0002DD-3Q; Mon, 25 May 2026 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=9605cd9704=quan.sun@windriver.com>)
 id 1wRa24-0002Ck-I4
 for qemu-devel@nongnu.org; Mon, 25 May 2026 14:28:09 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=9605cd9704=quan.sun@windriver.com>)
 id 1wRa1x-0002th-EQ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 14:28:06 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PIF2Le2954258; Mon, 25 May 2026 11:27:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=jMlaSK/Y9
 w7RQoO7pye8JkRxu/RMbh9XragWboC1LpU=; b=GxPoOpHd7ilUgQjf4c6Zcg6Vm
 dLbykRAGriohMe5fbKVfa+9HtaccHlhzz3oqiLmA4lju3l+88n41fTBGPWG3ljYU
 NzY7IR2Rny/L0rdL6WGV4U2IxkuIc9a0rGNyzYarQNZF6WZd3moUtsl1O0SD7HES
 wtGOC9lk8zOQ8QuzAL8/fJgKT+A9ecIX+W9bFnseJQERo82/kCpA1Fr1Nbxq3Ck9
 LBgcwjMICrFHzk4OPwXUm4KpCdVMXZiAaKOUFn9hl09tV623nj38+nneiLeGv7pT
 rKRZCS/ecEUn2KPL6i/2OukJanv3vFHZi2biPwPZCJ8bgrtEA9fxVc55Dpn8w==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ebbrejmf6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 25 May 2026 11:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAaqukYplYGPh3JHpYiRCOWycjuJMCwwMQRqmpHehTYSby1hyJUxdSXBPGm02xfYxoXJYHMJ/U5dsVJn/aGhjfzLcsGl7HkLz9r1nYIA7C5YerX4n/lbC09mvzVr2dYD5sEHd+/a6kKF1STsALxjEUQkSgOSJtyP8dBzCHlu4HoRR9IWn5+JZOhzPvF+tQRGR44wDep+L28nV16kMqSA59ta4btr89Egt+60vj1xh6Cu+eEWk0sgsNRlI+uH9bVRleA6cUgG42jEH2rs4nOwFmfuNKiIIjJd5FejQMlTfxMYFrn7R5R88p6UPo37LxtgeU++GYk27TUBmQWOyCfu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMlaSK/Y9w7RQoO7pye8JkRxu/RMbh9XragWboC1LpU=;
 b=FgHiLye5P5u+BvwfzvQaEvvSZW8bOw9qt08Oom5c8AGHsV+dbymR0x8y80ZnpYNnhyeizyG3JDZskoLELWLDnw4xqy3B4kdkmjWiFsE8kVcs9ny0iIU9HkIiqUsgwyfAwyBLr3FCeFwXgHHyUc/XWivqmmzCSY8au6kF6wO9RZ4B2Jy+ZiFJeht0ZYD5dYb53scBVmfJsgQE2FcwXlf2rv0KA55VXEfnFG4by4kiXbEjN90QOt2BgHP+YgM/aqczdqqGJGyC2oDPxkGcMA7XDjOyodtuMvlTeisDWCmJAjFN2T1l60sceGTR+v8V1/Pjye1GYh5jW26KIkDgof9YJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:27:48 +0000
Received: from IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8]) by IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 18:27:48 +0000
From: Quan.Sun@windriver.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com, sgarzare@redhat.com, 
 Quan.Sun@windriver.com
Subject: [PATCH] hw/scsi/vhost-scsi: fix build with older kernel headers
Date: Mon, 25 May 2026 11:27:30 -0700
Message-ID: <20260525182730.4098543-1-Quan.Sun@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To IA0PR11MB7283.namprd11.prod.outlook.com
 (2603:10b6:208:439::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7283:EE_|DM4PR11MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd48a3-cf37-4214-321f-08deba8b5256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: +GSC2BJRxQIUL4w6XxvWzdgWWHel0iGwj9OSnzTo+CzzVAVS7n2H4VIcN4vi5oHTLAWAqWaWn58F8231yYiMgDJjlB2+sM02mz2lXEucPAzAETthznYNbf5q0ybvAIAKcMs4KJlTN/k0tfwghSAv9DerQdMYqx5b2ZegKaO7yxBIdvKa7LG1BaS203eONdIL9XIciNWAr00adVvfm+Ji5ryuOj6PqbKNRbWogbcwVg7kVUpSbgJE4qiEXOq+MPirHRaKBZXe3KGgYZXuzJ9QEkjMxgnDPy09SWUxZT+XT1GnOgGnbvtyhREudr/flHWp0NYy5ufa/fxpBq+BB964nUHCKNW4Y3xgy+KJNQpF2Ki6Cgib2UQZxiwf0nQNRBPSqLIVMepKBaVh1vPZfiXhmcZhIZTbsDKUclaoEzuQtRL4ataJwwyGaYeiUO8vgcnFV/NO2Wn+EBUE4hRBE2NLDa/GIjs1AA3S6kXs5BWjUzhanLePTFm2hh9pbSZazGQhykbuthAksl9cTASb2MWJ5PnArSs3w2uP34KznfsWS2ZV37zIgGqFUWoYCnPcAbuXlg4PSWL/QJt0Aa5M7U/iCXo29oSYMCgGIxU8v5OXuN8S1h+yvUWCcLzTOC816ok3De7fBK7yhmbEc74GH7+06NVBYX4Ha6WzJOYIeNDyZp+go+SQb/uXxKgGzLLW6NUe8veFEpqURd0x8LMTvVGIN76g8SE68hSUTaxE8v7hpoY3qCAeHr0IsYiJayubydX6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/STb/s21hQFYaHtp+f+ECbHGwiY6Y4GPql6B1+nJscfmXBr9MAHNCKaf/MRk?=
 =?us-ascii?Q?x7sXsV333MyRmZusnAm6JcwgHBZORm0qHCdy8HnA0RGyay13corDDsBqbHQy?=
 =?us-ascii?Q?St/iHi4MW6jKb2XfElohzaX3ypOHGEG4B9Vf/+ut2jvhclavDI4lXQsM7RsE?=
 =?us-ascii?Q?YQlw9OCWDUEqAQrhM3c0g+2ObpMw5VPqtIdkM34tyUla2UvoNhvw/Fq7TPre?=
 =?us-ascii?Q?MR+43dsKHL3e6HMJKGj0qX6j9wITmBiKTNSE+eEdeEUdNRXUZN8VwiPhlyaF?=
 =?us-ascii?Q?ZU6CRW2ij42EuN8/1LMcG33raJCGa6VG0S9oG9IXXnaFVeltWXTus4sQYkhf?=
 =?us-ascii?Q?g+k1Grz8pi/8zPXyrXkMODXDW4os4wB5PUtIUIqgqHR+Jv7KZaLh+Ajb1KO7?=
 =?us-ascii?Q?8wa9tSEqecMh6PesKyjWRAP45YmQUkk+/sNGfILgCV/lp5MXm1ibjILyL5uh?=
 =?us-ascii?Q?dLPidCnfM8KR4UNlzX76TnkZi6YHpFCHTmwAsZDNyeeBH2b6mdO/dLXf3wcM?=
 =?us-ascii?Q?Jlp5n82lqlWyPQThgyiOSXuseRJ+PgAy+ZtvlsbOYSZMJsls5z+BFEzMwtsu?=
 =?us-ascii?Q?dvO5y0+LHxn1fAQ74NFaFmlB9WPeu5wUztee51oqs6oJ8LURso/LCndOnDSZ?=
 =?us-ascii?Q?+j2729ypIjroVL49aAXLPB6kxycDqe2jbGIhNoWYPJKCDdoqY6pUStVXBkdw?=
 =?us-ascii?Q?u4LoSSlKQoaaX4yV3DOP0URdnCIVL8XF/euiyDzoyvsTjuIKIawCEqQ0J1xA?=
 =?us-ascii?Q?+DMhPMosTF3wXDEXfWLak+6GhBARujICMaIY6foXFZP9xeQF5C8bj4t7Wv0X?=
 =?us-ascii?Q?iqawX/7j7jH8z2hUfdPDbRqmz6zoYHJdRPzKKYiA3COmkXT1K8RhIym+oo2j?=
 =?us-ascii?Q?3oUtK+u5kmyew1W2B6LtShRliZFLtPhZlUNYwSp3hjNajzgVjHvUhfZHhEsl?=
 =?us-ascii?Q?z1oLsy6IV2a27W5F1CHTtCkFt+f9AkUZwp5JcKbBzR1S96KSWg+ouclaifhh?=
 =?us-ascii?Q?Dm/zl2kkdsCYYA8YycItLM1HYwAjW8CJgvjBNhbrS4ISHW51qvqN5RZyhil3?=
 =?us-ascii?Q?5w2U8hpcVI4AOaW3A6ISjbOB6wRoLYeLvxUDnA4a6jbOaWmPUd1djualpYSM?=
 =?us-ascii?Q?B7w1hxzPsjAOaRztbCEmvqWbbSNOe4sSvF70EJ4VUlo/24bIK5MlH6Ilu7XV?=
 =?us-ascii?Q?6q1zFCkRxLOXiqxpKbz4r2AVH6ZuFFp/hh1u3zGJJbDRwzgq4f9mbMuyHqNO?=
 =?us-ascii?Q?apVxTuwzYc9SkxWWxkTHQG65ExIJkeC9RQ7bxkvnVopKmgGpvjr0PTyVzzum?=
 =?us-ascii?Q?LTqgIF7kaMmbccmau28U/TSzr4J4tmLktR9ln6V46G+FyTZcxsiJj9F3n8I3?=
 =?us-ascii?Q?KCeFRTioBmpfpTqXcHUEqMymNy3K+p3BNTVrr7naqSz/9gm73Puai/B0ocGc?=
 =?us-ascii?Q?FE/CxRWK+MwMnQsKWyn3qc5ZJ2TSEtyElKH5jcrf8scgylKM7NkTvqa1w6LP?=
 =?us-ascii?Q?VsPEUIBOSW3RkZbX93W+V1FUY9MjfEhjYi+yhHJTfdbpDTl7O1Vii3NnBEri?=
 =?us-ascii?Q?hCYLGhe7wcI8JaNvGA9JlJ3Xa/HxZd7UY4eT56cqR2wyo+QCqia2iKYlpvPD?=
 =?us-ascii?Q?uwuPVrydH/JJDbI9yDBkI36w+MT/JiwFjN1sPrsoE5fkp28xYWgF7ey8tjp5?=
 =?us-ascii?Q?pRzARwtGokRfLIzLxCfy3orUbwsTY9TW7g/cxFQGCuUnLKudnKKjJwSMvsbT?=
 =?us-ascii?Q?xpplBBy4/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: p9mOH4ruLqCWYn1Zv1lwymrEDrX1yv1r1wu1esnYcLNtMM5jEoUac41Aq1n4TlT+8t2AjBpqmPUAsbzQMHvjGE4E2n0Kr6acA8NLpgZe/clSYnZ4hXQ7Fe0yvf5A/5s2tQYcQm0nktAq5J6InX7zOkuctcl5sKVanM4ciRResBudLkb0YZPiqdlj+1ZS6ICZbVNYMgJeyVURbtO8q+fRwHvWCDXDjCB+wZQSbfWU9CruFYtKrfixRRySheti3iclPOuZZvNcM9Rae54moMXZ8HgmZZg2QCbzyAOw7IF9DO7t1SJD6yC70nlucVfOIPcVoaY7HD0PvLhf9k+0UdyJQw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd48a3-cf37-4214-321f-08deba8b5256
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:27:48.0773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDLNSu+qaxDfi4kgjpk+0ez9/vuDN8Ui+/Cg8lJ1W/i4r3PnSOdxFmjDflln5dy7tfnTQZJp6xIbg1ghFy2KHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-Proofpoint-GUID: JfJ-eHmHuWNfI0l1c_NDjH4NIhcK7UdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE4NCBTYWx0ZWRfX20Qjr8+kjYVm
 Y4ceR2vWm2GUbhp0JGNURi54UEEpVTUyswIExgzyE0E8+U/uJSwcy0vslrU2PE/njLhsa5BmYyq
 +Otybqpyz7mgUYfoM+gIl1iu4YcPuDe4q8QWC0qUf2gkinyUzHq2yZjjz+hGWPG5tgw3FJaHVlc
 Tef01iHK649WZTNk7OAPr+vDyn9U/as/I89YQK0VXX+JMMW6VtFJ8r/7JpL+r6lljjNaqDk9rHD
 Bq3ZnL5f4lTG+fpeIrvv9J9suvAk21w9LEGU4Taly7KZ3dcbgAy7EPmR+AMjH0kj8XL9P5CW3zY
 XaGe3dGDva6ZaLsnXOXJna4DYJ8S0DjzWWfa+e+l3wMQneaqF0pJ5CQEla7JKMZMvsexkX/UaLv
 g+FT0L3OUZ76bsbrPHcBpo84FPjSSnpa3u31Zzeh7biDOhg4o45gqJGge3mBSa7M7njcY7J4BXB
 Qqle/TJANJ83YMy07aQ==
X-Authority-Analysis: v=2.4 cv=IMUyzAvG c=1 sm=1 tr=0 ts=6a1494a7 cx=c_pps
 a=MzitxtHdenuwXKuz6QWlPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=tOh3b7mK2cmqlCsdpQIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: JfJ-eHmHuWNfI0l1c_NDjH4NIhcK7UdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250184
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=9605cd9704=quan.sun@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Quan Sun <Quan.Sun@windriver.com>

On build hosts with kernel headers older than 6.0, the system's
<linux/vhost_types.h> does not define struct vhost_vring_worker or
struct vhost_worker_state, causing compilation of vhost-scsi.c to
fail:

  error: storage size of 'vq_worker' isn't known

Fix by including standard-headers/linux/vhost_types.h before the
system's <linux/vhost.h>, matching the existing pattern used in
hw/virtio/vhost-backend.c. QEMU's bundled header provides the
struct definitions, and its include guard prevents redefinition
when the system header pulls in its own vhost_types.h.

Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
---
 hw/scsi/vhost-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 699863cc10..10e8fbe503 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "standard-headers/linux/vhost_types.h"
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
-- 
2.43.0


