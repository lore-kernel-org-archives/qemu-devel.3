Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5257C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZev-0001EU-Dc; Mon, 12 Feb 2024 11:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1rZZet-0001Cl-RV
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:59:55 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1rZZes-0001V0-8b
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:59:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbHO7gUm2sfb3TqYTfmH43PZRUtxN6BQ3/QRrl0U20Lqy6+H4vo2HTWTZHG0xm5tikOVeUroiJ/rXc77si/9VhgLWlZ2+PNB8q2NJlRBVBfdFIV1bsA9ghg/vjcIymYzQVaCS++uZfsalFKkhvBDWq8sqsDNV+fyakWyaNe1mnL2TgdB9A+yZvMaQRY2RjqjnWqvV/oGXDejczsQH0geT6SIGQBoN1uDbL+rRh7fFnrpAA9xPJajiDhBCnsJs6vyuQmsCD8kJx/PBpmy6uxNGjy54cRDVRO5Cp1zEiuDdHKNcC7DsMPRXJdMBjFa+3p4H4SOVUWbcoJFgAet5eiIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adJmg4rls/tpWAWVXVUp7+QxEB0kvH9E4oibEEX/ODU=;
 b=WkoLvAF0OTLknEBQcAzKSNc5wSqcTyASJH0PSmCDq7iXLf0oBkmaOD0M6T7WenIhrSsRTjd6O1LRxWh3konsDKdhv+8YmPDJF+asPvhQdKUzIPNCI25Fvw6Tul3MJVnof1hped7i26tImeYObvqByYAet96trcYkfrfssG7QE9Wue+tSiKvebN3AkFuNGxPrqteXMwhJw8N/qtYdMdEhWL0O5qRdohw+xJoWrJjNV/w4VN8mh5RATrLutxo2W5pV2f4qcj5CI/5oWDfI+lV33jA2W6OW7VyBj4XGvqpyMKPvX5g7UjQGm6LCqhxRYAty20n+/Gear0Mt0ew7900Czg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adJmg4rls/tpWAWVXVUp7+QxEB0kvH9E4oibEEX/ODU=;
 b=e0IuELcedxfPZ+dVxX5Vw5u0VM070ruOOIzOXjIrDt3h/ANSlamfipkQSchUz3tnhaAD4r+K8jkNUbzXOQgx4JwiqG5xMWc9I/+mYl7C1YULTZ0RvGguDilJ7+aR9PMAo7XLOpS6dOUZUnDFAcAkgmG3z8BXy8VN15DO6UM6XAshBSPzyp2A1tLjRiBd0q9rL0KU25s2ZE2cr5saXeMJGlodnng8+LzKXbTovLPxyYwhsCvnnecNEsu2UlhKqYsnxocOWMU17f8/dXlw8kuCxe7YDSxhG1RhVXu3uWzazoZV/XutAEQ19Ie3OFSdm1Z21R2gqjMk+kjABnTnLyDzOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 16:59:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 16:59:48 +0000
Date: Mon, 12 Feb 2024 12:59:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable
 hugepages
Message-ID: <20240212165946.GD4048826@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212135643.5858-7-joao.m.martins@oracle.com>
X-ClientProxiedBy: DM6PR02CA0165.namprd02.prod.outlook.com
 (2603:10b6:5:332::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d1010f-a49c-4fb2-eb2b-08dc2bec0551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeU1CcyoemokzNFeQDTGHf97OWErGSfdckMttnRsndMMI+MGD6gj3I66AqpsywfF4XnVirH9efOqMooJqvfYFJffRq/Bw3iHbYwD2DqGKvS4wSORMi6o/ZB0sv6d0yn0gmdtoARUe9BF6qoZrcOza1KQyrsqQuy7/Cv4C1VJrxVoBZ6bhIiePGugiDY9jHzXZJ4xH0+O+0Zn/JvfjdEJVuHjDM5tEqkfMKN2+s7GERpLEjv/BmsHtKxX+WE/TzjoswA7OJtb+Kz2lT/gZyYClU8V3R2hFdlG2lQf9Z217vjHWpNS/n12aNBtCCot8KWvS9RjoXiA94L/pTPD9Ex1vdH2OOvAZqjKjlGipC/zJoO6zNlw6oXG++oGDHAAiTjNtS3ux8lzSSWTr9ZLe71x6Co1pBPgLgVZpck7w4wxoS2ygauE1yPAZNL+Ct6RlRoppAkwo/2gwgFBE7PKslXxydkB9hvC1I1TdUr00QfYVMIEcC5bp1B1s1FI32qaTnnTHX2nRRsEPUMtH0Rtm4FytyJceZxlFRGkLX5Fj8TyXP3ehEIecbsbY+/loJtuMS2R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(478600001)(41300700001)(5660300002)(7416002)(8936002)(8676002)(4326008)(4744005)(2906002)(66946007)(66476007)(6916009)(54906003)(6506007)(6512007)(66556008)(316002)(26005)(86362001)(2616005)(107886003)(1076003)(38100700002)(36756003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JpLYGH4pKMOVAkUkdR+iFU+lQ0mD+8Nf8AP+9+//Y5k6q/9ywmFCTXJFeyJ?=
 =?us-ascii?Q?+a6CCIsaW21Bqw9VaCDH+EqrREEO8XlB9p5QqeC3lvfY5srSoFuJBlbjczqw?=
 =?us-ascii?Q?vgDBOKdYheVg1Y9az5QUWV56T0sGjZgNFY5FRtOefwpA5lvjnI+kybOJMe70?=
 =?us-ascii?Q?eqA9Wq5ME4R2Mbd+6yFK2zCaQmZeyv6hp+LfUj+0cKklrabDRB4ld8zeyzNZ?=
 =?us-ascii?Q?v6FgzYMcEO2yFYwIfoMQwOL7DG80rscY1Xgadoc05Vi8UyWkZMeZC/3n0fxT?=
 =?us-ascii?Q?yhDf1NAhhIlmk9yiCIUDdll5fnS2t9wCd5tYOTb+OgDf1xbM+xPmjGAPh18/?=
 =?us-ascii?Q?ex1pRfGRuF68w/Q9GvOAPtQ0/CGjQnIQCzL1DHywtyVnBXD3WUo1dF54zL78?=
 =?us-ascii?Q?fdaB/FC9YZwblHDDhyrjP6t46mGl/LtEtEDrB2ubVj3kGeFhBIFgGqDh8Lq6?=
 =?us-ascii?Q?OxWUEi6waurxSbLNUe9CJCw3COc9GhTKVJ4wwheOJuLNJNfPdRmvUVV2bFYu?=
 =?us-ascii?Q?dvXHo/QLmH9H1O5vCz5h1BE5gpmVHbALqYt1OE2KaMvgB7n865suK8DjQ6lG?=
 =?us-ascii?Q?wgtr+RPFr9cX9zZdgwZvK7+IQCj5KRNrWoSTY8N7TlIELujPA7By8fUpm9Ij?=
 =?us-ascii?Q?E1nXCf1AvtkkMXVPRkqw2mp2NQ2XY555VuYF8/IjipSHuY9wEDt+elbnUO6P?=
 =?us-ascii?Q?mqr+K7qbPmnuAQOEQ2zKu/XQRPRhfigYzfwKpsIICCXiAj7YnGzfTY2PNFqQ?=
 =?us-ascii?Q?bmTooHuCBCxLFtTverHYATYgEQ7y6cm1Cz5Zdu1Mj75F0hi2mOj10i+ntOxV?=
 =?us-ascii?Q?6joR4IncwdbEW3O7hp8U8lSajBxo7flnP+AsdO1inoKgFtjUgw++1rQXJJXI?=
 =?us-ascii?Q?LiBFM/AbliY12ib75nVQwTOY0gaI97AaOD9svc8OCbL0z+HY7cyr4/LnCc0c?=
 =?us-ascii?Q?rAtY0HvJB/HbHuvEPdhMKaGAaxvaeXq9cLBVLBs9ZX3rDVjP6GLPSpWaNsXz?=
 =?us-ascii?Q?cpMKJ9+dvDYbf22tLl6aM0f/tSSpXcgCjHoLjghfpfQdG5OAjj+6HjgYyRW3?=
 =?us-ascii?Q?mI2kWtb1kxZkiSWxxid+b1SrP7SSGTVmidtVTSCSs6LALmDA/62rSjXBB1ZW?=
 =?us-ascii?Q?3XUsAmmKCtDvkjpM5pNZFN/mrl1VmcL1Q+lChEDBJh7Z0AyhjTCXX5qxy0M0?=
 =?us-ascii?Q?f7PvMJJmPodRtdq5zbGqDD/mSX8SZaGpy8xu/pEjXRS6pPcNsi7eyT8i1qh5?=
 =?us-ascii?Q?sldXfk2tMl4164M0fU2ejIIrywe7Xs0JR7vjhmv7ZzmMn4pNBh6SNgk+uhhO?=
 =?us-ascii?Q?A2sCr96nTiJmKwB7XCTXLQ4ghUvymSVThSGiVddvpN64Vmmt3KTYekSb5s06?=
 =?us-ascii?Q?IWvV26PMjZ3fO7MTL9vJuL/BXMRdSrShtdNeyZ1esfMDhXGnzrPesivu0X4r?=
 =?us-ascii?Q?/tBK174VRtS7MQTmb7ij5tdiGtTx+6iQNdqVBgwg6/AK8tZbfReGg4rJC7+D?=
 =?us-ascii?Q?Wv8X1ED/tF6/xwcWxK5oAg6kB0m3P1txUG26ei22iVVjG1ZlNeap0LgEeMmA?=
 =?us-ascii?Q?PT83kXbBLtlGdMhYuaBq69tv+Kblu8D49vI2ef+U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d1010f-a49c-4fb2-eb2b-08dc2bec0551
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:59:48.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIkGLOk1AeHJXZfBFAhBMDA7EIgrBNIcLMOd/8eu1Jhzc4cuO92DOl1NGBc+3eMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Mon, Feb 12, 2024 at 01:56:41PM +0000, Joao Martins wrote:
> Allow disabling hugepages to be dirty track at base page
> granularity in similar vein to vfio_type1_iommu.disable_hugepages
> but per IOAS.

No objection to this, but I just wanted to observe I didn't imagine
using this option for this purpose. It should work OK but it is a
pretty big an inefficient hammer :)

Jason

