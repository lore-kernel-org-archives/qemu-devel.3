Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDFC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFkz-00059M-Pt; Wed, 31 Jan 2024 13:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVFkx-000597-JP
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:56:19 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVFku-00084q-Uv
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706727376; x=1738263376;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JnJAwKgTnhr9L0HTVWphEWOVhVUfpGKvrCQ1KWATxaA=;
 b=ISVmMSJj09exQ2p/A4k7X1Y8r3myzAUX9HJKGR2BMOtEa7wxywGt+jum
 CAIY93MIBT4x/9fVpexN51Ae0izf4RC4deghqQn7UAa2GOde52acLU9FI
 x61toHwgLnMh+7XbhqQadXgwUoPL5G82RcopgNOOdfaKGkFYxOu6UAZHk
 7sEt1TdeLGfyUdUk6Jb+NO0E56PZ0i0EHXhZfBKkwFwp38Plak7CkC4bn
 qkrnBNGPczwUEFJZyDpw4F+1udVHUi4TCcAmg13iAbfHgHOxDUjtj7vkb
 EE4thXBhXoyX1hc0szTmvoTBIL/OUoBFxY85sTM0zipycyHW9Fl6Erc6r Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394134735"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="394134735"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 10:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="22875683"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2024 10:56:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 10:56:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 10:56:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 10:56:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 10:56:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnzHYNpi9xW+Bmmn2pO2/rxalS14UifAXtlxREOb0J2/dUOaynQQ//uIZvQ/KkhSaUKI1ED0Pp5u025Dme0vcp47rbGJjBiDM7/0hUV7M+POPKsZV+pJt1rNK02D2rcMwiL/M2fmudlP3ipRSQyGIR8p2834haErpn+ABowRUu0V5T9EQytt1MaD5CG8C+PEk5SK/+KnZfaCZMUGwGoCF4CElULvzrQ4Ec40bS1HI15Emt65WGRLstcvlnWNskxpXPbzhlhSy6p1Rjcti5zzNuFz72EQyMJ8uR9K5zXhNMbuLVjfw0uC7viqaoStMcJ3+VnkauJ8E8pNov9P9xW05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnJAwKgTnhr9L0HTVWphEWOVhVUfpGKvrCQ1KWATxaA=;
 b=PIeA/64Lx7VkNEYT/YhMBdoiQI+jskAg3KDl1OhHWJQgFNJv3zXCh9kijOL46mLvl+d6N+SbJGQ9fQiMieAFxFcYcJbjZTlW3u0EfphP76CSfGA3rgqTgguMwqdSscrlziJvtnezoByqdw/pBHtqxAvgr9vBQgdZiTInJL7VFp/adc7HUBqSBYSQ+En3vpoLIz1dc7c5i9oBigjpAwoadp5Ua3B0pIh5YB0E85c/MM78nzvyYDIgv5NkkC8musvefwwl8URtMBdODhYVFGXotJzIWQ+ur/HZP1RnA+8daCquDNTzuV2syMjYHtopDqLO8dkWGpWeXw22h7NA083/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 18:56:09 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d%6]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 18:56:09 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Thread-Topic: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Thread-Index: AQHaU9fcRg8sk5PypUazkJHR2gMsqbDzgQeAgADEP6A=
Date: Wed, 31 Jan 2024 18:56:09 +0000
Message-ID: <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
In-Reply-To: <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ0PR11MB5920:EE_
x-ms-office365-filtering-correlation-id: c5857208-e967-4f0e-cb37-08dc228e495e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2qD5rNjZzIVv4nqHBToMstNlKWeNnpC1EFK6mwg+uFHmAvvXs+ILec0K5yh87e6G+Rsh7UZsJVVvDmyycPei69fGqygIimuSUfRevrHuZL7s1CzTy7L32plqmwMTbv6JhYGs4nFSVNt2xBMH1NL6aF75BQozxXAncJB0tosq+CTbfKbKUgKiVvZlbWmsUFB0aBMin8GoKqjunn70H0Cr7u8MU6Hpxfeg4uUIuPDw5l5FZD1yNvSak3A3RFjCz+y7l9tYVGrNqmPJD9c/QKN85dWPS/ai64pjzusMIizQ/kWUU/DuVkDPnaUeQQuBuuRcdN9loMg7hL7wp7ScTL5W3wIoyX6ba321nMkTTYGrmErMX+AiKd2c1flxRfK7LAQGz0mCsgfNf5O2Qo2EyV8OQCNgfJFnPXXmAxndvVVQ7bUwSGQokMGInVDZaNUv/FBiyF7OCyvn/ibSeP4f9OMLE5qruKjDAIdgWO+KPHtRPu4fK0S4ni9HXt6Gyk/U/nTT9JOcVjJUoYV+P8UdWpLkL5zsQw2uzbMmRjOYbhHqAUYTtyn7W0rn1VOXYhysixi/ZyxPnIF72+fHowh4ode3LErapLuXA7jTMO4DEGpjH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(9686003)(52536014)(6916009)(478600001)(71200400001)(53546011)(8676002)(316002)(7696005)(6506007)(8936002)(4326008)(2906002)(83380400001)(5660300002)(38100700002)(122000001)(26005)(966005)(55016003)(86362001)(33656002)(82960400001)(41300700001)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkpqdTRHUnQxaXI3QU1GY3VRdnZSWHJsdjhxQlU2R1lFU0NsTDRzRjZyN3A5?=
 =?utf-8?B?elZFcHh5STA4MC9BYUtyanRSNTZFblBTdWk2Si9IM1dGK01tUWE3cGlSQmFL?=
 =?utf-8?B?RUdXNzBGTlBrKzJtUVBuRXpzRlRsUE1BVXdYc3p4Ri8ybkk2Z0hDWmt6YWpw?=
 =?utf-8?B?blBaTjRxdDVybUV1b1h4R2FNWmpKSlVHQVNsTjhMUE16WElFWGJWS04weHVQ?=
 =?utf-8?B?MGloeXNCaWlNOTFtUnFHRXJKNU9yQ09MQWRKZlB2QnBPQUtsV0FSbTh3OEtC?=
 =?utf-8?B?K1h1LzA5MkhvQ3VoR3VHWUxsL1JMaHRjWkZpODRjQ1hNM1FJVmRGMndxcGxz?=
 =?utf-8?B?enRCRDdpdUs4NjQ2Qm02d0gwU25YeWZnUGpLR2FNUHl5YWlHSkcybUlaNHYz?=
 =?utf-8?B?UmxOODY1blZTcnp1YnRsbWpoeHd5SFhTRlhWRGp4SHU5VDYzQUN6SForRS84?=
 =?utf-8?B?WStJemc3cmQwdW9Td2xWcHNONmhYbHFJbXJmQ2VlUzRWVlN5UVEyQjI5cEdI?=
 =?utf-8?B?emNBRFBLd09LTnZVUXp3ZXhETlFnTGRveTFhQWNOZnRRS0YrQ0tIUlBQdzE5?=
 =?utf-8?B?WDBCSnQzYlFWeDdnM2s4dEhkVk5RMHhRdUlwK20rR0l5WktGUnZPVFJMdDZv?=
 =?utf-8?B?T3pPV1kxdnRFZUtTdFplRkNJaWlzRCtiajZ6WURwTitRV0UyNVovNVNPR0lh?=
 =?utf-8?B?WUZnZ0h4Ny9nckJmZ1lUZE9uWFREczhFOGk1V0h4dWpXeDlmRENzRUFycmUw?=
 =?utf-8?B?dzA4RGYybXJVYTJCUW1DSVdvM3JqckVZL1RvdC9tMmdjRFpNOU8xQUxVditD?=
 =?utf-8?B?bFZGSW9zcUoreU9vZ1JhaGU0Rk1FbHR0cHcxZkxjZ1hSRVBrL01nZWl0VzV1?=
 =?utf-8?B?elRhUWJzeEN0UFBHbC9DYStuVDQrR2dJVUw3eGdscW4zMTQ1c29XdWZ3Q1BW?=
 =?utf-8?B?YVlpNDBSVFRQOWN0RkxIQkEwVFRsMlQwbVVUc214aEx4dGNibFFZVzV2YnJy?=
 =?utf-8?B?WW1HYThiYitucWRuMk85QmJiY3YzeDZCM2QwQmU5NGFqMEtmU3BPMG9NTUxp?=
 =?utf-8?B?RlBFdUxqQkUwZ3dUcFFidW9oL3FzQ253dGJVQVRjYnlyaDEvZE11aUJJZEVq?=
 =?utf-8?B?VkpkSktQOXUrMVpzWU5ySndUZjZzME9VS0hkTXZJLzhIV08rRUR4eW56YzdG?=
 =?utf-8?B?UmRVbDVlQStJRzhISUJpNUdXT2k4OFNyaUgrMm5EQlhYVU9ONlhuNm9oc1Fx?=
 =?utf-8?B?aGtDU3kzMldBaCtDUFNPczM0TUdRS2p3NSs3cEYrN1FsMmVjamprTGJQU1U4?=
 =?utf-8?B?Y3JQZ2xIUFQ2ZGNRaHBtRU50aHRqVVhkMlc4eUdGZUFHRXc1UGNrZzJleG1n?=
 =?utf-8?B?Tm5hRThMZzJ1VUxidlZ2SHpaZ2MxZmhZMnJhRTlLL0hIeDJUQlpsTTFZU1NH?=
 =?utf-8?B?RCtLWXk0QlB0cnlLdnZ1WjF6b0dmOEhVVURFdHdTa0xsMFNUblE0bFZkMlZn?=
 =?utf-8?B?Ulk4Q1JIRnBCMXVYdmUwY3dWdVdpMFJ1RklTU3RCV0pOQkxtV2FoNkZqVUx5?=
 =?utf-8?B?ZmptaHAvQURvSVViQ0dOTlZMYXc0NnNYcnEydGZ2dXkvOTF0V0Q2TUZncHJa?=
 =?utf-8?B?K0EyV3lLTEtBeWVRYlEzYXg2VVYxS2Z0cVRkbUpjWHJvMTB0TG5sQmNSbzBp?=
 =?utf-8?B?OHZSVGZVblZOY2U1N1N0dUt6a2RKdEtKT0d2TVlzNmE0Z3V4aC9sWUYzQWZQ?=
 =?utf-8?B?TEVzV3NaTVVHWndQNXB4SjJ6clIxQlg1NmRmRWM1TklqVCtCV1A0d25DWktX?=
 =?utf-8?B?SkN1RWJlT21NbUFKbllTZE9sT3NCOXo1NUZ2WjgrR1lmNWdZYnV3UzdFcm03?=
 =?utf-8?B?Q2tTZmk0TS9LM0tPZlNmUVlTYzNxYWNlV0ZuMDYzYVFNNU1NNkFzdVllSUtF?=
 =?utf-8?B?RS9KWG10V1ZnZnhxMUhIemp2QURRL2FuU3hIejVkbXA3dUthNUIrUkxDdjRi?=
 =?utf-8?B?ZC9NZTVzMVlYQ200aFUvKzAyRVJPTFN0b1F3RDh6eklqdjA0aHhaMHZJckpE?=
 =?utf-8?B?NEIvWjRybVlWRWFIOXlCeFo2OUN2OUdUTEU3Y09jMVJzN2pETlo5RWRZWHpv?=
 =?utf-8?Q?82O7aee+PvSyA/Jjf8qAZH6YQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5857208-e967-4f0e-cb37-08dc228e495e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 18:56:09.1385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfP2uLl8D+8Jolr2tq9C9LZ/5m6+MrhjAEngKOoJ+uiXVPxx5hbCd/5zWNBTvEp2r8khcVby0OHxbg9nKu0Rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gaHR0cHM6Ly9kb2NzLmd0ay5vcmcvZ3RrMy9tZXRob2QuV2lk
Z2V0LmlzX3Zpc2libGUuaHRtbA0KDQpUaGlzIGlzIHdoYXQgd2UgaGFkIHRyaWVkIGZpcnN0IGJ1
dCBpdCBkaWRuJ3Qgc2VlbSB0byB3b3JrIGZvciB0aGUgY2FzZSBvZiB3aW5kb3cgbWluaW1pemF0
aW9uLg0KSSBzZWUgdGhlIHZpc2libGUgZmxhZyBmb3IgdGhlIEdUSyB3aWRnZXQgZGlkbid0IHNl
ZW0gdG8gYmUgdG9nZ2xlZCBmb3Igc29tZSByZWFzb24uIEFuZCB3aGVuDQpjbG9zaW5nIHdpbmRv
dywgdmMtPndpbmRvdyB3aWRnZXQgaXMgZGVzdHJveWVkIHNvIGl0IGlzIG5vdCBwb3NzaWJsZSB0
byBjaGVjayB0aGUgZmxhZyB1c2luZw0KdGhpcyBHVEsgZnVuY3Rpb24uIEhhdmluZyBleHRyYSBm
bGFnIGJvdW5kIHRvIFZDIHdhcyBtb3N0IGludHVpdGl2ZSBmb3IgdGhlIGxvZ2ljIEkgd2FudGVk
IHRvDQppbXBsZW1lbnQuDQoNClRoYW5rcyEhDQpEVw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8zXSB1aS9ndGs6IHNraXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4gYXNzb2NpYXRlZA0K
PiBWQyBpcyBpbnZpc2libGUNCj4gDQo+IEhpIERvbmd3b24NCj4gDQo+IE9uIFdlZCwgSmFuIDMx
LCAyMDI0IGF0IDM6NTDigK9BTSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBB
IG5ldyBmbGFnICJ2aXNpYmxlIiBpcyBhZGRlZCB0byBzaG93IHZpc2liaWxpdHkgc3RhdHVzIG9m
IHRoZSBnZnggY29uc29sZS4NCj4gPiBUaGUgZmxhZyBpcyBzZXQgdG8gJ3RydWUnIHdoZW4gdGhl
IFZDIGlzIHZpc2libGUgYnV0IHNldCB0byAnZmFsc2UnDQo+ID4gd2hlbiBpdCBpcyBoaWRkZW4g
b3IgY2xvc2VkLiBXaGVuIHRoZSBWQyBpcyBpbnZpc2libGUsIGRyYXdpbmcgZ3Vlc3QNCj4gPiBm
cmFtZXMgc2hvdWxkIGJlIHNraXBwZWQgYXMgaXQgd2lsbCBuZXZlciBiZSBjb21wbGV0ZWQgYW5k
IGl0IHdvdWxkDQo+ID4gcG90ZW50aWFsbHkgbG9jayB1cCB0aGUgZ3Vlc3QgZGlzcGxheSBlc3Bl
Y2lhbGx5IHdoZW4gYmxvYiBzY2Fub3V0IGlzIHVzZWQuDQo+IA0KPiBDYW4ndCBpdCBza2lwIGRy
YXdpbmcgd2hlbiB0aGUgd2lkZ2V0IGlzIG5vdCB2aXNpYmxlIGluc3RlYWQ/DQo+IGh0dHBzOi8v
ZG9jcy5ndGsub3JnL2d0azMvbWV0aG9kLldpZGdldC5pc192aXNpYmxlLmh0bWwNCj4gDQo+ID4N
Cj4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+
DQo+ID4gQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBWaXZl
ayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+
ICBpbmNsdWRlL3VpL2d0ay5oIHwgIDEgKw0KPiA+ICB1aS9ndGstZWdsLmMgICAgIHwgIDggKysr
KysrKysNCj4gPiAgdWkvZ3RrLWdsLWFyZWEuYyB8ICA4ICsrKysrKysrDQo+ID4gIHVpL2d0ay5j
ICAgICAgICAgfCAxMCArKysrKysrKystDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWkv
Z3RrLmggYi9pbmNsdWRlL3VpL2d0ay5oIGluZGV4DQo+ID4gYWEzZDYzNzAyOS4uMmRlMzhlNTcy
NCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VpL2d0ay5oDQo+ID4gKysrIGIvaW5jbHVkZS91
aS9ndGsuaA0KPiA+IEBAIC01Nyw2ICs1Nyw3IEBAIHR5cGVkZWYgc3RydWN0IFZpcnR1YWxHZnhD
b25zb2xlIHsNCj4gPiAgICAgIGJvb2wgeTBfdG9wOw0KPiA+ICAgICAgYm9vbCBzY2Fub3V0X21v
ZGU7DQo+ID4gICAgICBib29sIGhhc19kbWFidWY7DQo+ID4gKyAgICBib29sIHZpc2libGU7DQo+
ID4gICNlbmRpZg0KPiA+ICB9IFZpcnR1YWxHZnhDb25zb2xlOw0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL3VpL2d0ay1lZ2wuYyBiL3VpL2d0ay1lZ2wuYyBpbmRleCAzYWY1YWM1YmNmLi45OTNjMjgz
MTkxDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLWVnbC5jDQo+ID4gKysrIGIvdWkvZ3Rr
LWVnbC5jDQo+ID4gQEAgLTI2NSw2ICsyNjUsMTAgQEAgdm9pZA0KPiBnZF9lZ2xfc2Nhbm91dF9k
bWFidWYoRGlzcGxheUNoYW5nZUxpc3RlbmVyDQo+ID4gKmRjbCwgICNpZmRlZiBDT05GSUdfR0JN
DQo+ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBjb250YWluZXJfb2YoZGNsLCBWaXJ0dWFs
Q29uc29sZSwgZ2Z4LmRjbCk7DQo+ID4NCj4gPiArICAgIGlmICghdmMtPmdmeC52aXNpYmxlKSB7
DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIGVnbE1h
a2VDdXJyZW50KHFlbXVfZWdsX2Rpc3BsYXksIHZjLT5nZnguZXN1cmZhY2UsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICB2Yy0+Z2Z4LmVzdXJmYWNlLCB2Yy0+Z2Z4LmVjdHgpOw0KPiA+DQo+ID4g
QEAgLTM2Myw2ICszNjcsMTAgQEAgdm9pZCBnZF9lZ2xfZmx1c2goRGlzcGxheUNoYW5nZUxpc3Rl
bmVyICpkY2wsDQo+ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBjb250YWluZXJfb2YoZGNs
LCBWaXJ0dWFsQ29uc29sZSwgZ2Z4LmRjbCk7DQo+ID4gICAgICBHdGtXaWRnZXQgKmFyZWEgPSB2
Yy0+Z2Z4LmRyYXdpbmdfYXJlYTsNCj4gPg0KPiA+ICsgICAgaWYgKCF2Yy0+Z2Z4LnZpc2libGUp
IHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgaWYg
KHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmICYmICF2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0NCj4g
PmRyYXdfc3VibWl0dGVkKSB7DQo+ID4gICAgICAgICAgZ3JhcGhpY19od19nbF9ibG9jayh2Yy0+
Z2Z4LmRjbC5jb24sIHRydWUpOw0KPiA+ICAgICAgICAgIHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVm
LT5kcmF3X3N1Ym1pdHRlZCA9IHRydWU7IGRpZmYgLS1naXQNCj4gPiBhL3VpL2d0ay1nbC1hcmVh
LmMgYi91aS9ndGstZ2wtYXJlYS5jIGluZGV4IDUyZGNhYzE2MWUuLjA0ZTA3YmQ3ZWUNCj4gPiAx
MDA2NDQNCj4gPiAtLS0gYS91aS9ndGstZ2wtYXJlYS5jDQo+ID4gKysrIGIvdWkvZ3RrLWdsLWFy
ZWEuYw0KPiA+IEBAIC0yODUsNiArMjg1LDEwIEBAIHZvaWQNCj4gPiBnZF9nbF9hcmVhX3NjYW5v
dXRfZmx1c2goRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsICB7DQo+ID4gICAgICBWaXJ0dWFs
Q29uc29sZSAqdmMgPSBjb250YWluZXJfb2YoZGNsLCBWaXJ0dWFsQ29uc29sZSwgZ2Z4LmRjbCk7
DQo+ID4NCj4gPiArICAgIGlmICghdmMtPmdmeC52aXNpYmxlKSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIGlmICh2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRt
YWJ1ZiAmJiAhdmMtPmdmeC5ndWVzdF9mYi5kbWFidWYtDQo+ID5kcmF3X3N1Ym1pdHRlZCkgew0K
PiA+ICAgICAgICAgIGdyYXBoaWNfaHdfZ2xfYmxvY2sodmMtPmdmeC5kY2wuY29uLCB0cnVlKTsN
Cj4gPiAgICAgICAgICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+ZHJhd19zdWJtaXR0ZWQgPSB0
cnVlOyBAQCAtMjk5LDYNCj4gPiArMzAzLDEwIEBAIHZvaWQgZ2RfZ2xfYXJlYV9zY2Fub3V0X2Rt
YWJ1ZihEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwNCj4gPiAjaWZkZWYgQ09ORklHX0dCTQ0K
PiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0gY29udGFpbmVyX29mKGRjbCwgVmlydHVhbENv
bnNvbGUsIGdmeC5kY2wpOw0KPiA+DQo+ID4gKyAgICBpZiAoIXZjLT5nZngudmlzaWJsZSkgew0K
PiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICBndGtfZ2xf
YXJlYV9tYWtlX2N1cnJlbnQoR1RLX0dMX0FSRUEodmMtPmdmeC5kcmF3aW5nX2FyZWEpKTsNCj4g
PiAgICAgIGVnbF9kbWFidWZfaW1wb3J0X3RleHR1cmUoZG1hYnVmKTsNCj4gPiAgICAgIGlmICgh
ZG1hYnVmLT50ZXh0dXJlKSB7DQo+ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3RrLmMN
Cj4gPiBpbmRleCA4MTBkN2ZjNzk2Li4wMmViNjY3ZDhhIDEwMDY0NA0KPiA+IC0tLSBhL3VpL2d0
ay5jDQo+ID4gKysrIGIvdWkvZ3RrLmMNCj4gPiBAQCAtMTMxMiwxNSArMTMxMiwyMCBAQCBzdGF0
aWMgdm9pZCBnZF9tZW51X3F1aXQoR3RrTWVudUl0ZW0gKml0ZW0sDQo+ID4gdm9pZCAqb3BhcXVl
KSAgc3RhdGljIHZvaWQgZ2RfbWVudV9zd2l0Y2hfdmMoR3RrTWVudUl0ZW0gKml0ZW0sIHZvaWQN
Cj4gPiAqb3BhcXVlKSAgew0KPiA+ICAgICAgR3RrRGlzcGxheVN0YXRlICpzID0gb3BhcXVlOw0K
PiA+IC0gICAgVmlydHVhbENvbnNvbGUgKnZjID0gZ2RfdmNfZmluZF9ieV9tZW51KHMpOw0KPiA+
ICsgICAgVmlydHVhbENvbnNvbGUgKnZjOw0KPiA+ICAgICAgR3RrTm90ZWJvb2sgKm5iID0gR1RL
X05PVEVCT09LKHMtPm5vdGVib29rKTsNCj4gPiAgICAgIGdpbnQgcGFnZTsNCj4gPg0KPiA+ICsg
ICAgdmMgPSBnZF92Y19maW5kX2N1cnJlbnQocyk7DQo+ID4gKyAgICB2Yy0+Z2Z4LnZpc2libGUg
PSBmYWxzZTsNCj4gPiArDQo+ID4gKyAgICB2YyA9IGdkX3ZjX2ZpbmRfYnlfbWVudShzKTsNCj4g
PiAgICAgIGd0a19yZWxlYXNlX21vZGlmaWVycyhzKTsNCj4gPiAgICAgIGlmICh2Yykgew0KPiA+
ICAgICAgICAgIHBhZ2UgPSBndGtfbm90ZWJvb2tfcGFnZV9udW0obmIsIHZjLT50YWJfaXRlbSk7
DQo+ID4gICAgICAgICAgZ3RrX25vdGVib29rX3NldF9jdXJyZW50X3BhZ2UobmIsIHBhZ2UpOw0K
PiA+ICAgICAgICAgIGd0a193aWRnZXRfZ3JhYl9mb2N1cyh2Yy0+Zm9jdXMpOw0KPiA+ICsgICAg
ICAgIHZjLT5nZngudmlzaWJsZSA9IHRydWU7DQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+
IEBAIC0xMzUwLDYgKzEzNTUsNyBAQCBzdGF0aWMgZ2Jvb2xlYW4gZ2RfdGFiX3dpbmRvd19jbG9z
ZShHdGtXaWRnZXQNCj4gKndpZGdldCwgR2RrRXZlbnQgKmV2ZW50LA0KPiA+ICAgICAgVmlydHVh
bENvbnNvbGUgKnZjID0gb3BhcXVlOw0KPiA+ICAgICAgR3RrRGlzcGxheVN0YXRlICpzID0gdmMt
PnM7DQo+ID4NCj4gPiArICAgIHZjLT5nZngudmlzaWJsZSA9IGZhbHNlOw0KPiA+ICAgICAgZ3Rr
X3dpZGdldF9zZXRfc2Vuc2l0aXZlKHZjLT5tZW51X2l0ZW0sIHRydWUpOw0KPiA+ICAgICAgZ2Rf
d2lkZ2V0X3JlcGFyZW50KHZjLT53aW5kb3csIHMtPm5vdGVib29rLCB2Yy0+dGFiX2l0ZW0pOw0K
PiA+ICAgICAgZ3RrX25vdGVib29rX3NldF90YWJfbGFiZWxfdGV4dChHVEtfTk9URUJPT0socy0+
bm90ZWJvb2spLA0KPiA+IEBAIC0xNDIzLDYgKzE0MjksNyBAQCBzdGF0aWMgdm9pZCBnZF9tZW51
X3VudGFiaWZ5KEd0a01lbnVJdGVtICppdGVtLA0KPiB2b2lkICpvcGFxdWUpDQo+ID4gICAgICAg
ICAgZ2RfdXBkYXRlX2dlb21ldHJ5X2hpbnRzKHZjKTsNCj4gPiAgICAgICAgICBnZF91cGRhdGVf
Y2FwdGlvbihzKTsNCj4gPiAgICAgIH0NCj4gPiArICAgIHZjLT5nZngudmlzaWJsZSA9IHRydWU7
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBnZF9tZW51X3Nob3dfbWVudWJhcihHdGtN
ZW51SXRlbSAqaXRlbSwgdm9pZCAqb3BhcXVlKQ0KPiBAQA0KPiA+IC0yNDcxLDYgKzI0NzgsNyBA
QCBzdGF0aWMgdm9pZCBndGtfZGlzcGxheV9pbml0KERpc3BsYXlTdGF0ZSAqZHMsDQo+ID4gRGlz
cGxheU9wdGlvbnMgKm9wdHMpICAjaWZkZWYgQ09ORklHX0dUS19DTElQQk9BUkQNCj4gPiAgICAg
IGdkX2NsaXBib2FyZF9pbml0KHMpOw0KPiA+ICAjZW5kaWYgLyogQ09ORklHX0dUS19DTElQQk9B
UkQgKi8NCj4gPiArICAgIHZjLT5nZngudmlzaWJsZSA9IHRydWU7DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgdm9pZCBlYXJseV9ndGtfZGlzcGxheV9pbml0KERpc3BsYXlPcHRpb25zICpvcHRz
KQ0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5k
csOpIEx1cmVhdQ0K

