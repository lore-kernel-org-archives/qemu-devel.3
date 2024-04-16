Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D585C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk4k-00029h-Rw; Tue, 16 Apr 2024 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8836c35b9d=aidan_leuck@selinc.com>)
 id 1rwk4g-0001lm-Jw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:46:18 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8836c35b9d=aidan_leuck@selinc.com>)
 id 1rwk4d-0002rw-5o
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:46:18 -0400
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43GDIYH1028560; Tue, 16 Apr 2024 07:46:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=sel1;
 bh=WdrTEq3M5C1mTiUCGAOaGNYAeriNL5JX/XKhn4+Yeco=; b=Z4ZfLArej5qq
 Es8L8X1maHtOJH47DFUPzBh3DncxlyWNA2MHQBjK+lM0LryfOWDvOwF0b6RFQSPl
 bkqt6hEWIgFjq9qz0Stm+EwPnaNqlbiPD1hom4Hov6BfR7rBF1QPpZbyNdMkA7hM
 GXZvJdYs1r81pS30o7iwkzcMjeo4L4asZSkQtEepoPt57G4taFO8LCwablav5nDa
 EO963/j3Ef+q7ES5+j3MlSIvso0z23f4UpEq3TgHOV77JZgPKqhnNWAgqeKxMoBu
 zyzG8IQcHZkw3abGnHlFXHk7V4DeNSpd6oNRSmhLrrdyWCTdhbh1U8SJ8AmgsVk4
 cBQyOn8EOQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xht3s821h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 07:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqJtfRmA+dFVvIZFN6uW6WYNdyQ4oD3mGXqjpLkDkp+p+78TM6uKn6s9jV7xJ0CWbMu9hIyr8rozaPRwulXumxod551WNMnSUjggCJXn2cm8R3jqK2cESYGEhFK/JQrS6cAnvgIyYB4YstZ8GVltOiRhH/t+Z1XhON2UipRYptJ0wVToX0w7C+iibKOlAGT1rLMeDwpcHYfv28TZCtrq+AT9SsB4i8oMeHwnqeYqtpCbZiSs3cY8ONDKIJywUZaGnmB+6MWABdvHb1xTPQxGziZo4YHaUbJXcFL+AV44iXUbTo10z5Yf8NPPbjtkdSHUmj5sRKtkLeXeIfv1KsdtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdrTEq3M5C1mTiUCGAOaGNYAeriNL5JX/XKhn4+Yeco=;
 b=k1pIx5vardMwJNHUKBSgd2+kfDuLomgV2/bo1inMCyCQzx+XMwc04VK7n7QvNahMAFHhgNksnakqerQliVy7eUlgjeZu+7AJkUirGGtt6ySG64HftPWp9ueqE50cyWGQf/6a72dP00rLQkyByG3hEvHfXSW8XknLD/oaR5jFKABcZI/3YJ5/Oc4FOGGtJJlGgi6/dAavc4dWg+NfDS/+l+kfRzofT/yWpyvHICIC+KaYMCAYyF/V5hDeH65Iop9D9a8Kp26zkqZKdTk2L8j9/1F+D0TN9TcN7LuBbI0ylSjhsIzjoVy1jvEbXBs+06FIqQWUADYGHnSt9cOruk9KEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdrTEq3M5C1mTiUCGAOaGNYAeriNL5JX/XKhn4+Yeco=;
 b=da7vpGCUCqOl+D8BWd4l5OWLFhLjz2Au2sd90LxmN06NhPeDEdcZXDkfLb3aRUGC0kAR6qOfJ8EGffKXfRZJXhdbbrilsKRyi3OtzfwanXW6Yd1/ly/qp1wfJ0JJayg5lfmE+SMlSCvH50dYyoGpLUC+WcmZL/Xz8OyPeWIWXnhnLszaFmGJdPUn1ykbUjM5PPdUsLNFGCqVnH5mrq36BlEFMT+VtoydyrjTBePUXtPOR/CYG4ItBxQB+B7sahh452JpbdsKUC/O6susDi++bDEP3CFGxwGC2UpUc18a8D+4p1ni/LS+gNchOJnLU+4XOHDTVqRIcMNciv+xVVGOTg==
Received: from LV8PR22MB4551.namprd22.prod.outlook.com (2603:10b6:408:191::9)
 by LV3PR22MB4744.namprd22.prod.outlook.com (2603:10b6:408:1d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:46:05 +0000
Received: from LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0]) by LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:46:05 +0000
From: Aidan Leuck <aidan_leuck@selinc.com>
To: Aidan Leuck <aidan_leuck@selinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "kkostiuk@redhat.com" <kkostiuk@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: RE: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows
Thread-Topic: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows
Thread-Index: AQHage5GnKvq88Jja02P5GWzysuOArFrE4dQ
Date: Tue, 16 Apr 2024 14:46:05 +0000
Message-ID: <LV8PR22MB4551BA53C529BBFB006CF581E3082@LV8PR22MB4551.namprd22.prod.outlook.com>
References: <20240329153155.17840-1-aidan_leuck@selinc.com>
In-Reply-To: <20240329153155.17840-1-aidan_leuck@selinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR22MB4551:EE_|LV3PR22MB4744:EE_
x-ms-office365-filtering-correlation-id: 3ce3da02-a751-4924-f2be-08dc5e23f1e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qynoN68TJqHgBowVBFjVhpMe7kry3dKHWNr+HmwajrlLCEMQc3WbsiE2StuhePx3Ic+VvvOvvMHHivsv9h2iNawHErj4a/kkl+0656O3tt5nd3fMGVkvVcVc56OG6G69655jQ5yUUJBcAD7S7s0KMkGc+c7KVpMV8/CW7n4iiE5owYrAqKMcI63LaCNjgr8wgyzuP+6JJv0J3FuIf/vtC+RUAGa5b3Fb55B6T2SOVy4BuXxiXWlru7A1kjYpmGQVDZMWztbtG6/Ypv+OckwJnViOCG6aGwuppn+rRAW5yv5RpveT3f5W63+kz/+6ICKgMkXowHR+CuEANrBm6+AVpfb3WKVkN+XUKVd8TpHCAKXkSj+OWcrJhyRYM9pWKTleTJWZw++VyakK9HdF+56FlUJ9tqom73Cjs7El4JQ1F4v0hL2EB3u7C6Qqg5fT/+grLwpOjbdR+uzBaz6dhkxezQH+oXnen/xGEwrHJW+EQaeVHG+xADuxo0udQOmd/iXBTih7eseEnvQ8gXperr8Q14/Z5txbyG4WQh0s3lnW4H7J14TbtJUelUisoluGoKiCYtWbKWs6DU38bFNYHqmilJZpZn6LXLK0ryqRcVRCgocnwiHnZzbybLj5jnWDa1aIGxXNDBh4M9r8jdKxhJ7GYDPmEDxiVmHWncAF7XX0qCQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR22MB4551.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gXjIkoJaV/2/mgWWrARaF5YrGCWRA5xzIXUt1QBx3SnaoZMdKs33Ff1VkCDB?=
 =?us-ascii?Q?J7YNQUci5NJoy4du6OKUuhl8W3y5AMSejlChIR6UonjOMeeWzbUoSjX5EjsV?=
 =?us-ascii?Q?QSJqzYenjXqmrRCDEnh9YW9tkWx5T8UrIleKrfpazg4LjL50Lbh6Gd8ekX1F?=
 =?us-ascii?Q?7FDldDMC9l2CtzlQmO0VMIHeqbEaPQfgurgl0w7KzRWvbIGBeNIMsCOU1L/L?=
 =?us-ascii?Q?TiFmE/2dJRlT9LA5sHbZOcM8QiPu5RjNeDzNwaIG7Ifvdaq16omVXwcUFVe/?=
 =?us-ascii?Q?fYvExawYKi8WbgTmcJyBmQBUEoLycqcbvJ7Y4GbBjvcNY18iPRuv32y/t82Q?=
 =?us-ascii?Q?9a5mGjGESJLumz2b+/o38vjUE9k4oDLoUEd0uOuhhsE1+vCwiYHzLBrZjfHp?=
 =?us-ascii?Q?IQHiATmMe5XBySTn8cHMTaY0kAQ9PhLgFhQ/hGTL/09Yc5AXzLtG05p28Eav?=
 =?us-ascii?Q?Q/h6pUG3eopJLjYC9X33mv0yuMyzR7jdAoEeod0VMnsquGJ39B8QfKmuoZkp?=
 =?us-ascii?Q?ARMpJ2VrY2+piBA67EDPHwHvxbUaY8d0GutoGyOZlTpCyAaNkeguPG3Eil5x?=
 =?us-ascii?Q?7AQ7cBT/CtkUzvjjmuRXE6Qnk+7Fa73Q20EbMl4/oIdIL2IT6J5FOY7zv5ke?=
 =?us-ascii?Q?SjAHTMn7s8xaT8Y+BtdWnEwSzsXeaO4R2nnsGBSjQpgRp3euNLosp4omH3eY?=
 =?us-ascii?Q?KZ6FRYOnB6NgqMzkpDLvlTwUGcDisLiGNf2xJrxNfmoDFw78/z/MVEoRBEc/?=
 =?us-ascii?Q?VuNC9h/PYVHFa8WK6im+bg7djH3V8WMYqj2o2Mf+QTfcBmB793D85TP+oeLO?=
 =?us-ascii?Q?Py+lewn6p59bXUfkUtRbZvPBaoqxza2ZDCNHya8i05XzRhssO96ZiIIyS3T8?=
 =?us-ascii?Q?mXvwHmIrclBTzb8B6wTcL4vS0suIz3zu9ZkXTkTUHhupJhNEXeF1/71Dotl8?=
 =?us-ascii?Q?jgOzyXa4VyBoDmzq6GFPnnnwpBhcieCyuu/K8FLJeTSdkZ27c9tft72Keh6T?=
 =?us-ascii?Q?yBzW6FBPWstfdJK3TxTE+rnGCwjQJA/rv2GSDqL+17d20NJznuHdMjlSz25R?=
 =?us-ascii?Q?N4JZDnDHklrNkr6CXA/Gg7RSOXSgDxz3qIWao5byGok+1Mcez3i2VOUq6RGg?=
 =?us-ascii?Q?b9b80Dnh91+q9yYXenirFp8bGOdYSNUaUpthOn7M2Wnb1x/iz/Fj806KahHD?=
 =?us-ascii?Q?JydTW4i8WPqi9CPdHh3URaiOcemzcTLEFVMECFR6cOg4O8lcA4faOt36w6DF?=
 =?us-ascii?Q?9MpABu4YEIY9Ao1vJkKtxvqDpr18pB/DtqvSETGJv1tipIAigXL1WsIkxWvz?=
 =?us-ascii?Q?vXpmR4JCbL5QYndc8popC1yGcOrohdni413LU5GgEinpUHyFjenpkHhAgaA9?=
 =?us-ascii?Q?1qlBy4ftDbNxyjw2Qnq+xPn2V4R8MaGP2p0l6tLn0ob6g1Fzdk4PHNW3S0TI?=
 =?us-ascii?Q?CakAuds7mCEI5YQ0eP5/pfsHX+j0CHxponna00PvjxvuiBs/TE/0n4N2izE2?=
 =?us-ascii?Q?zYw2Twj+RnKlnIzpLXIY3rCG/CF8NPwwXuz95PReyaJ8sGLI06PU+J9P+LOI?=
 =?us-ascii?Q?R+8tTdZIhJNNYmp+ZocpfOq6ofw3oYpakjfsg8X5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR22MB4551.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce3da02-a751-4924-f2be-08dc5e23f1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:46:05.4160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMPhBc8rNYH5oJfz4xJ1hizJJYp7e143RVCoEFApamIZ1AP3F3/tjzQC+IO0ldXvXdybNfPCi92riMOoAjbC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB4744
X-Proofpoint-ORIG-GUID: bo7lD_7WW5gvsIP1ElyjSjiWGZjqyccl
X-Proofpoint-GUID: bo7lD_7WW5gvsIP1ElyjSjiWGZjqyccl
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=865 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160090
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=8836c35b9d=aidan_leuck@selinc.com;
 helo=mx0a-000e8d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Hello Konstantin,=20

Is there anything you would like to see addresses in this patch before it m=
erges? This patch has been up for a bit and there hasn't been any activity =
in a while. Our team is motivated to get this merged, so let me know if the=
re is anything I can do on my end to make the review easier for you. I unde=
rstand as a maintainer your position is voluntary and unpaid so if you just=
 haven't had time to look it over and validate it, I completely understand.=
=20

Thank you,
Aidan Leuck

-----Original Message-----
From: aidan_leuck@selinc.com <aidan_leuck@selinc.com>=20
Sent: Friday, March 29, 2024 9:32 AM
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com; philmd@linaro.org; Aidan Leuck <aidan_leuck@selinc=
.com>
Subject: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows

From: aidaleuc <aidan_leuck@selinc.com>

This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remov=
e-authorized-keys, and guest-ssh-get-authorized-keys for Windows. This PR i=
s based on Microsoft's OpenSSH implementation https://github.com/PowerShell=
/Win32-OpenSSH. The guest agents will support Kubevirt and allow guest agen=
t propagation to be used to dynamically inject SSH keys.=20
https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machines/=
#dynamic-ssh-public-key-injection-via-qemu-guest-agent

Changes since v5
* Fixed spurious formatting=20

Changes since v4
* Moved qapi/error.h to commands-common-ssh.c
* Changed <qga-qapi-types.h> to "qapi/qapi-builtin-types.h"=20
* Removed stbool.h from commands-common-ssh.h

Changes since v3
* Renamed commands-ssh-core.c/h to commands-common-ssh.c/h
* Fixed styling errors discovered by checkpatch.pl
* Moved some header includes to the commands-common-ssh.h

Changes since v2
* Set indent to 4 spaces
* Moved all comments to C style comments
* Fixed a segfault bug in get_user_info function related to non zeroed memo=
ry when a user did not exist.
* Used g_new0 instead of g_malloc where applicable
* Modified newlines in qapi-schema.json
* Added newlines at the end of all files
* GError functions now use g_autoptr instead of being freed manually.
* Refactored get_ssh_folder to remove goto error statement
* Fixed uninitialized variable pgDataW
* Modified patch order so that the generalization patch is the first patch
* Removed unnecssary ZeroMemory calls

Changes since v1
* Fixed styling errors
* Moved from wcstombs to g_utf functions
* Removed unnecessary if checks on calls to free
* Fixed copyright headers
* Refactored create_acl functions into base function, admin function and us=
er function
* Removed unused user count function
* Split up refactor of existing code into a separate patch

aidaleuc (2):
  Refactor common functions between POSIX and Windows implementation
  Implement SSH commands in QEMU GA for Windows

 qga/commands-common-ssh.c  |  50 +++
 qga/commands-common-ssh.h  |  10 +
 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |  12 +-
 qga/qapi-schema.json       |  17 +-
 7 files changed, 893 insertions(+), 58 deletions(-)  create mode 100644 qg=
a/commands-common-ssh.c  create mode 100644 qga/commands-common-ssh.h  crea=
te mode 100644 qga/commands-windows-ssh.c  create mode 100644 qga/commands-=
windows-ssh.h

--
2.34.1


