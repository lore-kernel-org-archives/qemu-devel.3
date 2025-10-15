Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6623CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EK-0003LO-OJ; Wed, 15 Oct 2025 09:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EC-0003I2-Mb; Wed, 15 Oct 2025 09:07:40 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E4-0000mj-Oa; Wed, 15 Oct 2025 09:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncNEvmxxIYqeP+nWy//jb6QZc2GKcHMBmjx7gLS3tAmH/YTsFkXx31beQR27Ayalw/UMn33MtOvU9AX1JBwmTA8vJ/8xvqmHRxBYKoONcveCR266fw0lIYXxLUnaVx+Ft9UFnPUr1ZuwjiTAiWJmk50b1t/Nk6C7BNtvnHAEBtHR7F80TBjynuDH+8mLgUmc2gmgmWdtmA8kC2ZuTPk9dCq//nZgesnTw4bws35mAt59Rx2jXbikdQfFFIfyqpYdcwIDi6V5XhAWkAocow2H2y/rRtds5hH1IVC+V53OUnv8lW80Lcsyxd3eQuH9hNFoGT5IG2hJp8H+d/KPTtbpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+3exLfeVNjR6MT8PEqEtWKE90Rq+K2x/Z05qzkdUGc=;
 b=Q1MwZa7lnQMAAD0jRdF5T/uPt4dwpIq2+gevxYaEVaF9vqJexOHdEhxQbqPw7Imv07FiGFSN2N5DC9Vk3AGySMcub8OGOFKZlru3obdbCq3Srsp6DOgoVBeNakUOlUBQFaapvs0+VfnnrqkXtzOOQHizGil2tEtTd4YWy7hq9pdHFGk0161LHQwzLboNV8qGrLu8hm8FUQEXbMI4Cw3Qy4weLej3HcZFxjenGFRn1F3CSDr6KSJMAxHB6/9dCig5waiIsi1vuiEkjm8a/deHFfXSCjG3S3sTJy7BEunZUiuIUWMPCiMjrAGcscBi+BIVPv0PCNhmXrlkpWJODiOpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+3exLfeVNjR6MT8PEqEtWKE90Rq+K2x/Z05qzkdUGc=;
 b=g80vbG6czwv0+fX2sFkEfsZC7ym46RDSpwhxrZWaCqvg3fqR13l+Nke0VvMkfugMAWqZYLrplmv91zA3Laud8idejzRRoKZVxZ2SmFjxo46hSx7aYgMQOfm1Yg7+yghzMMHAUvrHbapwUaHTRCBXrt3uikjI7D7tFk6IOKUSGuon7H2sWhCgmmiM5AtvwcpSRPjQr2snLGsAXiwLZPfMDqoNmBCDPtn6Jc8U2eV0fPwFtPaKAZnIR7b6QMO4ov0+gOlzrSRlaGqibwm9BB96bvuwDsv8ciNCg3RtsiFzcAj5JlZPXTbCJHmg0yLOea0h5z3kMwfvhrRKneZjEmIc+g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:03 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:03 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v12 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v12 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcPdSZx7Sk0nq6B0O8p6a+ldjTnQ==
Date: Wed, 15 Oct 2025 13:07:03 +0000
Message-ID: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 7e66d683-e9fe-4dc5-9306-08de0bebbbe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6jPpWheG7mCg3lt0O/xhs3ar2rRwrZ/H89aUnNyIId/O0hxQgQ3zrpwCN4?=
 =?iso-8859-1?Q?nTDUYsa4JQUD5qtwpZPPIdP8LymsOCnKwueXrQmbbWsAOJhL2O3oSSljtj?=
 =?iso-8859-1?Q?Ie8o5OahijGBXOtqTju9Ak7OEwkzN6hA6l6hQXBHr0gZ9OgwgOnocLyl6+?=
 =?iso-8859-1?Q?fP1D+wiJJIjf1pT5kjpJAUy4KKK/igpk1h/VFMHdxz0JNQXHga5NVD4wvc?=
 =?iso-8859-1?Q?OBQBX+ktNUug+h8QTGZO1A5CguykPyOlxNiIj/g3aocs3YYybWm2tHu3hD?=
 =?iso-8859-1?Q?yadCujBo1FPGa2QIq1HPEkkw0IQDyVoReopPF+w92ohW6V7sY40C/da7GI?=
 =?iso-8859-1?Q?Qk3OmeFq71aN7iobxXSOxR4kAZHi9+cNkWzYBwXGn8t8kCcwHmWv78pYio?=
 =?iso-8859-1?Q?2HMP7bzYutBGx7LEzzdn1oM0b9HeNE2cEi50ukvMjdBFd2yIiZZEg5G/EO?=
 =?iso-8859-1?Q?CHGQ8wJg4eQRqGCVoaDCiPvdUiHab97Jo7YgUxdYYitUJ1doruzVjT9WIQ?=
 =?iso-8859-1?Q?RrEGdbyTaxuqfxpJCQIEjvcjkr+l2mlU4W3KX9I6PCIEdMYZLiGCob58Ka?=
 =?iso-8859-1?Q?ZN9jacAuIRHDyEmUtvEHpwgz5rHLjgOoMAQ15+mszxqpoD+RvcUeG/2Rn6?=
 =?iso-8859-1?Q?U/HmzY4lTi2w+xIN2QIPLUkGygruDGzXSlYxz8aOJY8dI+FjPwu6LUP3h6?=
 =?iso-8859-1?Q?6pDAjIAwL7EMn8Bopfz6iCl1Df4hWD/ceCpH0v1J9wrr/gNqoidLzQliLu?=
 =?iso-8859-1?Q?xpRQ0nNM6qPJi7OiEl9b4YMjVA1+TvFmZjwyo+NY3OUC3iL162Tel1MtpV?=
 =?iso-8859-1?Q?dMnWGfvA4T3tG9+nR40FXG7DcumSw9vac8SEpous7B6tIiRajx5cHd3nKz?=
 =?iso-8859-1?Q?wALgAPamXtW0jYeQUm4MdMkNsP4mtae+5jRd2nwht8Apgvw101R8qj0WXp?=
 =?iso-8859-1?Q?xUyhdv8odWokH/mAznn087XB1pKPsesAZ8BjclMOPDZ/o5E4Kj5Ipz6yT1?=
 =?iso-8859-1?Q?XYm8hxxFm9HGiRGyMNVUmJMuh8ws/a/CGpe410aRnQdY33WqJnckZZB6Tm?=
 =?iso-8859-1?Q?Sf+HeirEcqdFEkyNXQfuctGuynYQgXgJ1skvjONZmKW7U5RClvDPmi9oXu?=
 =?iso-8859-1?Q?XaY74T/e91LCqBcvm7pU7EH8PCF2uU+6+AwWtqUYxCUuYihY9UqQ813A3h?=
 =?iso-8859-1?Q?VWq29SVKuVpQx7kAtBfHIg8HxQCwqRYPtS2UbKW8+8z5zKfmyL8l18Tu2E?=
 =?iso-8859-1?Q?AgSBAEfXEAbFLwnNWiF5oRW+OMgHBfFRwE2CqH3vQEzkTS/YC6SiRXH5NZ?=
 =?iso-8859-1?Q?YmdVsTJXA/mAyRGOkyUYcMWefd8XpFpGhGbOojHzM86d6uNgPWmmQghTK1?=
 =?iso-8859-1?Q?kJrtDkLYnK787O0wY9AQYrzCNH/P6ZWVqRnfn7dLBjh+V00BaU4a9CDGVr?=
 =?iso-8859-1?Q?WxQYxP6TBLcBdhGOf5mIipJ9lSekuAusaeJiJ/UI1IKah0+d7LCD6HUdig?=
 =?iso-8859-1?Q?OoX1BfgnMRgscDe74RnwPFBp2uM3IuKgF7zOjA80nopawZHqt/M3318fNc?=
 =?iso-8859-1?Q?6Hkquug4V4Bn5S/Q0xO2YOUNWQLK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rr8u+qmDA1TF/WmBvLZv3sKV6kh9QgdsBZKA0i6kGXWmgsCqIYki/JVz7J?=
 =?iso-8859-1?Q?VSQ6Iy8nbU5gA8VH2bXndhgLF27al6BwEc7/ZExU+B8rRjWjcG27kIWq7M?=
 =?iso-8859-1?Q?evLRiUXkjX5Pyc7hcFId8vm+1497iH6OlujrFK1qLfdkswNApIYAIKiH4z?=
 =?iso-8859-1?Q?XgCkq2BXwOVms0fPLSSHC3Ls6V2jJGgHyblBaR/bl2CTFMvN/t0xHVJ76D?=
 =?iso-8859-1?Q?Qu45cGjRUODj7MFrSzXigmMAe6TTDD2BHUQd6o+09MJBW7cHSnf0gKOybL?=
 =?iso-8859-1?Q?XEhn7P4tzKj8nfKOCtPYbN4QsAjRdXeBjsgIb+ZDMPwOhCqwnH52wsQ1JM?=
 =?iso-8859-1?Q?9J7Xei8+rxMhSfbugdkQGceOspt6cdi4g9CTJaX3Ymn3lR6V/SHDTu48QC?=
 =?iso-8859-1?Q?Ueg34QBxkhVDq6nCqaxWzAirRAPX68Ss9CSsbUqj/pUN2WSwbfbZ3tCApk?=
 =?iso-8859-1?Q?FjQMr+Kb/X5tnpa+VPyHGqaaulhI8f8BKzxM/kYLrtOA8HHnsDXrnZR7E9?=
 =?iso-8859-1?Q?/YnOemY554I5+LipBohEcaI+3rLS3NqEauBsSXYXMo1iIU8hEVck8mYhlV?=
 =?iso-8859-1?Q?yZ6iY/H8j4laqkn38rNWOXHGUyYrzthL6Wg117/dwbMqScxnOIKGGR4zbp?=
 =?iso-8859-1?Q?XqSUoPnH84EoFe40XVMP8OKb9YSgGTLLXEz0BoryM4y1xoED8N38dcj1B7?=
 =?iso-8859-1?Q?cnH80C1m71uyGKTvbKZD1pgUciLKWCiF1dTR2qlELdEVVbjhoWJA4RSReB?=
 =?iso-8859-1?Q?1YHYiZrqlOW4iFRwK0Sm1H3+l27tEoN40AcocCjG4aJSSkkI7gy6x4RjzW?=
 =?iso-8859-1?Q?UugygFoknTyuoUnocLDuP2wdbjh6gJHhY3yqFnJKmhd1Ug0WziHMchbZlm?=
 =?iso-8859-1?Q?l452+p4cG5SW7epYJ1/5g36QOE+8fHjDiRrdCLU+v/11Kcf+TJNlm5OhkO?=
 =?iso-8859-1?Q?UjfMrmY1bL7WCTHVEr6lp397IA6IL1c6+3uxGNY9JtwprHyD8bgEwDVsQf?=
 =?iso-8859-1?Q?470mVFerOnhGJCGN28yl8JXLa6Kb1Fu8Na1jwDZQAJl9HaGvyHlCZ2Zy/d?=
 =?iso-8859-1?Q?rXjJE6uHPt8HLJ2VtnE61kOcG5yXLPb6isP7wQ/FPdSbrlW1JPIxivqJ4l?=
 =?iso-8859-1?Q?ZS9NmTOmv26GcCCbkoaZCzv1AcNPG/9OQZn3lfjndqoqo2zPkM4gghTjba?=
 =?iso-8859-1?Q?McwHTDOcqwCfEkMu2UhNW8voHsbPX8g7WZq+lq1Keg4fF7RaR/CFN7ecrN?=
 =?iso-8859-1?Q?LXkCZ6h0g3BiBUKcrLeJ7hCLJJ1+TLiglZzSDTmv4sqpPD1Q4fbhgC2TIc?=
 =?iso-8859-1?Q?QbIVHQ1CRSceKJG/s/dglvPhtmf4UJDuiS71mjqaMXTqEqKhH+A7jDLMYo?=
 =?iso-8859-1?Q?SnNgXOk5RmDuhaxSQo7BeSRPrvefLQmepOA3XYacBt5zhhQdElR4IPoUc7?=
 =?iso-8859-1?Q?HHxnTWOL0z/gwW9JglqBkK4dGrgP9NFuXBuJMxLhipWlphmekxpdQzhhrB?=
 =?iso-8859-1?Q?+5gSBQo/nTENxBNMzDFnLuEkL6KgKdkJkMmmUKXe1EkDKLN05MVVe/hS+s?=
 =?iso-8859-1?Q?b9S3WkzvBU8LuFl6nx3NVlCGWAjxpj0cYWkM3kWFBVSd1Lrk9sCM4Ucug2?=
 =?iso-8859-1?Q?vUVSXPh4tYTI8wGjrgYRuImS7DWAPKq/b0apyZMK8PXjxA56Nd323th0A0?=
 =?iso-8859-1?Q?QEU66N/zMycluHo3Tbk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e66d683-e9fe-4dc5-9306-08de0bebbbe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:03.0769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 455JE2SvW6HFrS9mn0ZDNNgaoKbKmEqzALuj1n78zKMedLupLwyb1ZKuhRyu5u0+0gV5ye/aY71pYBWy4uIYibIPcy88Gwxv6rt875G6nYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In this version I renamed:
  tests/functional/riscv64/test_riscv64_boston.py
  -->
  tests/functional/riscv64/test_boston.py

Djordje Todorovic (13):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  18 +-
 hw/intc/riscv_aplic.c                       |  13 +-
 hw/misc/Kconfig                             |  17 +
 hw/misc/meson.build                         |   3 +
 hw/misc/riscv_cmgcr.c                       | 248 ++++++++++
 hw/misc/riscv_cpc.c                         | 265 +++++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
 hw/riscv/cps.c                              | 196 ++++++++
 hw/riscv/meson.build                        |   3 +
 include/hw/misc/riscv_cmgcr.h               |  50 ++
 include/hw/misc/riscv_cpc.h                 |  64 +++
 include/hw/riscv/cps.h                      |  66 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  44 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 217 +++++++++
 target/riscv/translate.c                    |   3 +
 target/riscv/xmips.decode                   |  35 ++
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_boston.py     | 123 +++++
 29 files changed, 2021 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_boston.py

--=20
2.34.1

